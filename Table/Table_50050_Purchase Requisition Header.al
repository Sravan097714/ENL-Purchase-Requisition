table 50050 "Purchase Requisition Header"
{
    fields
    {
        field(1; "Request No."; Code[20])
        {
            trigger OnValidate();
            var
                PurchSetup: Record "Purchases & Payables Setup";
                NoSeriesMgmt: Codeunit NoSeriesManagement;
            begin
                IF "Request No." <> xRec."Request No." THEN BEGIN
                    PurchSetup.GET;
                    PurchSetup.TESTFIELD("Purchase Requisition Nos.");
                    NoSeriesMgmt.TestManual(PurchSetup."Purchase Requisition Nos.");
                    "No. Series" := '';
                END;
            end;
        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Initiator';
            TableRelation = "Web Users"."No.";
            trigger OnValidate()
            var
                WebUser: Record "Web Users";
            begin
                ValidateApprovalSetup();
                if WebUser.Get("Employee No.") then;
                "Employee Name" := WebUser."First Name";
            end;
        }
        field(3; "Employee Name"; Text[50])
        {
            Caption = 'Initiator Name';
            Editable = false;
        }
        field(4; "Date of Request"; Date) { }
        field(5; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            TableRelation = "Employee Department Setup"."Shortcut Dimension 1 Code" where("Employee No." = field("Employee No."));
            trigger OnValidate()
            begin
                ValidateApprovalSetup();
            end;
        }
        field(6; "Purchase Type"; Code[20])
        {
            TableRelation = "Purchase Types".Code;
            trigger OnValidate()
            begin
                ValidateApprovalSetup();
            end;
        }
        field(7; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = 'Dimension 2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

        }
        field(12; VendorInvNo; Code[35])
        {
            DataClassification = CustomerContent;
        }
        field(14; "ShortcutDimension 2 Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(9; Status; enum "Request Header Status")
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                StatusOnValidate();
            end;
        }
        field(10; "No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(25; "Web Link"; Text[250])
        {
            DataClassification = CustomerContent;
            ExtendedDatatype = URL;
        }
        field(30; "Approval Limit"; Decimal)
        {
            DataClassification = CustomerContent;
            BlankZero = true;
        }
        field(31; "Approval Request Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(35; "Copy Date"; DateTime)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(41; "Validation Date"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        field(42; RequestedBy; Text[50])
        {
            Caption = 'Requested By';
            DataClassification = CustomerContent;
            TableRelation = Staff.Name;
            ValidateTableRelation = false;
        }
        field(80; "Transaction Type"; Enum "Transaction Types")
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                RequestLine: Record "Purchase Requisition Line";
            begin
                RequestLine.SetRange("Request No.", Rec."Request No.");
                if not RequestLine.IsEmpty then
                    RequestLine.ModifyAll("Transaction Type", Rec."Transaction Type");
            end;
        }
        field(81; "Currency Code"; Option)
        {
            OptionMembers = "","USD","EUR","ZAR","GBP";
            Caption = 'Currency Code';
        }
        field(82; Description; Text[50])
        {
            //OptionMembers = "","USD","EUR","ZAR","GBP";
            Caption = 'Description';
        }
        field(83; Totalamount; Decimal)
        {
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            Caption = 'Total Amount';
            CalcFormula = sum("Purchase Requisition Line"."Amount Excl VAT" where("Request No." = field("Request No.")));
        }


    }

    keys
    {
        key(PK; "Request No.")
        {
            Clustered = true;
        }
        key(Key1; "Date of Request")
        {

        }
    }

    trigger OnInsert()
    var
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgmt: Codeunit NoSeriesManagement;
    begin
        IF "Request No." = '' THEN BEGIN
            PurchSetup.GET;
            PurchSetup.TESTFIELD("Purchase Requisition Nos.");
            NoSeriesMgmt.InitSeries(PurchSetup."Purchase Requisition Nos.", xRec."No. Series", 0D, "Request No.", "No. Series");
        END;
        if "Date of Request" = 0D then
            "Date of Request" := Today;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    var
        PRLine: Record "Purchase Requisition Line";
    begin
        PRLine.SetRange("Request No.", Rec."Request No.");
        if not PRLine.IsEmpty() then
            PRLine.DeleteAll(true);
    end;

    trigger OnRename()
    begin

    end;

    procedure AssistEdit(OldPurchReqHdr: Record "Purchase Requisition Header"): Boolean;
    var
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgmt: Codeunit NoSeriesManagement;
    begin
        PurchSetup.GET;
        PurchSetup.TESTFIELD("Purchase Requisition Nos.");
        IF NoSeriesMgmt.SelectSeries(PurchSetup."Purchase Requisition Nos.", OldPurchReqHdr."No. Series", "No. Series") THEN BEGIN
            NoSeriesMgmt.SetSeries("Request No.");
            EXIT(TRUE);
        END;

    end;

    local procedure ValidateApprovalSetup()
    var
        WebApprSetup: Record "Web Approval Setup";
    begin
        if "Shortcut Dimension 1 Code" <> '' then
            WebApprSetup.SetRange("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
        if "Purchase Type" <> '' then
            WebApprSetup.SetRange("Purchase Type", "Purchase Type");
        WebApprSetup.FilterGroup(-1);
        WebApprSetup.SetRange(Initiator, "Employee No.");
        WebApprSetup.SetRange("Initiator Delegator", "Employee No.");
        if WebApprSetup.IsEmpty() then
            Error('Approval Setup not found.');
    end;

    local procedure StatusOnValidate()
    var
        ReqLine: Record "Purchase Requisition Line";
        ReqApprEntry: Record "Request Approval Entry";
        SupplierGrouping: Record "Supplier Grouping Header";
    begin
        if xRec.Status = Rec.Status then
            exit;
        ReqLine.reset;
        ReqLine.SetRange("Request No.", "Request No.");
        if ReqLine.FindSet() then
            repeat
                ReqLine.TestField("Vendor No.");
                ReqLine.TestField("Amount Excl VAT");
            until ReqLine.Next() = 0;

        case Status of
            Status::"Pending Approval":
                begin
                    if xRec.Status <> xRec.Status::Open then
                        exit;
                    ReqApprEntry.reset;
                    ReqApprEntry.SetRange("Request No.", "Request No.");
                    ReqApprEntry.SetRange("Approval Level", 1);
                    ReqApprEntry.FindSet();
                    repeat
                        if ReqApprEntry."Use Deligate" then
                            MailNotify(ReqApprEntry, ReqApprEntry."Deligate No.", 'Send')
                        else
                            MailNotify(ReqApprEntry, ReqApprEntry."Approver No.", 'Send');
                    until ReqApprEntry.Next() = 0;
                end;
            Status::Approved, Status::"Partly Approved":
                begin
                    if xRec.Status <> xRec.Status::"Pending Approval" then
                        exit;
                    SupplierGrouping.Reset();
                    SupplierGrouping.SetRange("Request No.", "Request No.");
                    SupplierGrouping.SetRange(Status, SupplierGrouping.Status::Approved);
                    if SupplierGrouping.FindSet() then
                        repeat
                            ReqLine.reset;
                            ReqLine.SetRange("Request No.", "Request No.");
                            ReqLine.SetRange("Vendor No.", SupplierGrouping."Vendor No.");
                            ReqLine.ModifyAll("Ready for PO", true);
                        until SupplierGrouping.Next() = 0;
                end;
            Status::Rejected:
                begin
                    if xRec.Status <> xRec.Status::"Pending Approval" then
                        exit;
                    //if "Employee No." <> '' then
                    //  MailNotify("Employee No.", 'Rejected');
                end;
        end;
    end;

    procedure MailNotify(ReqApprEntry: Record "Request Approval Entry"; Recipient: Code[20]; NotifyType: Text[10])
    var
        SMTPSetup: Record "SMTP Mail Setup";
        WebUser: Record "Web Users";
        RequestHdr: Record "Purchase Requisition Header";
        PurchTypes: Record "Purchase Types";
        Vendor: Record Vendor;
        SMTPMail: Codeunit "SMTP Mail";
        SenderAddr: Text;
        RecipientAddr: Text;
        SubjectTxt: Text;
        BodyTxt: Text;
        HyperlinkTxt: Text;
        HtmlTxt: Label '<a href="%1">Web link</a>';
    begin
        if not RequestHdr.Get(ReqApprEntry."Request No.") then
            exit;
        if Recipient = '' then
            exit;
        SMTPSetup.Get();
        SenderAddr := SMTPSetup."User ID";
        if (SenderAddr = '') then
            exit;
        WebUser.Get(Recipient);
        if WebUser.Email = '' then
            exit;
        RecipientAddr := WebUser.Email;

        if not PurchTypes.Get(RequestHdr."Purchase Type") then
            Clear(PurchTypes);
        if not Vendor.Get(ReqApprEntry."Vendor No.") then
            Clear(Vendor);

        if "Web Link" <> '' then
            HyperlinkTxt := StrSubstNo(HtmlTxt, "Web Link");

        BodyTxt := '<!DOCTYPE html><html><body>';
        BodyTxt += '<Pre style="font-family:Arial;">';
        case NotifyType of
            'Send':
                begin
                    SubjectTxt := 'New Purchase Request';
                    BodyTxt += StrSubstNo(SMTPSetup."Body (Request Mail to Approver)",
                                            WebUser."First Name",
                                            "Request No.",
                                            RequestHdr."Employee Name",
                                            RequestHdr."Shortcut Dimension 1 Code",
                                            PurchTypes.Description,
                                            Vendor.Name,
                                            HyperlinkTxt);
                end;
            'Approved', 'Rejected':
                begin
                    SubjectTxt := 'Purchase Request Approval Completed';
                    BodyTxt += StrSubstNo(SMTPSetup."Body (Request Mail to Sender)",
                                            WebUser."First Name",
                                            "Request No.",
                                            '',
                                            RequestHdr."Shortcut Dimension 1 Code",
                                            PurchTypes.Description,
                                            Vendor.Name,
                                            HyperlinkTxt);
                end;
        end;
        BodyTxt += '</pre>';
        BodyTxt += '</body></html>';
        SMTPMail.CreateMessage(SenderAddr, SenderAddr, RecipientAddr, SubjectTxt, BodyTxt, true);
        SMTPMail.Send();
    end;
}