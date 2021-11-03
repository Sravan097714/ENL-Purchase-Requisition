table 50051 "Purchase Requisition Line"
{
    fields
    {
        field(1; "Request No."; code[20]) { }
        field(2; "Line No."; Integer) { }
        field(5; "Employee No."; Code[20])
        {
            Caption = 'Initiator';
            TableRelation = "Web Users"."No.";
            trigger OnValidate()
            var
                WebUser: Record "Web Users";
            begin
                if WebUser.Get("Employee No.") then;
                "Employee Name" := WebUser."First Name";
            end;
        }
        field(6; "Employee Name"; Text[50])
        {
            Caption = 'Initiator Name';
            Editable = false;
        }
        field(7; "Date Created"; Date) { }
        field(11; "Purchase Type"; code[20])
        {
            //will update automatically from header
            TableRelation = "Purchase Types".Code;
        }
        field(12; "G/L Account No."; Code[20])
        {
            TableRelation = "G/L Account"."No." where("Purchase Type" = field("Purchase Type"), "Direct Posting" = filter(true), "Account Type" = filter(Posting),
            Blocked = filter(false));
            trigger OnValidate()
            var
                GLAcc: Record "G/L Account";
            begin
                if GLAcc.Get("G/L Account No.") then;
                Description := GLAcc.Name;
            end;
        }
        field(13; Description; text[100]) { }
        field(20; Quantity; Decimal)
        {
            BlankZero = true;
            InitValue = 1;
            trigger OnValidate()
            begin
                "Amount Excl VAT" := Quantity * "Unit Price";
            end;
        }
        field(21; "Unit Price"; Decimal)
        {
            BlankZero = true;
            trigger OnValidate()
            begin
                "Amount Excl VAT" := Quantity * "Unit Price";
            end;
        }
        field(22; "Amount Excl VAT"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(23; "Expected Delivery Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(32; "Vendor No."; Code[20])
        {
            TableRelation = Vendor."No." where(Blocked = filter(" "));
            trigger OnValidate()
            var
                Vendor: Record Vendor;
            begin
                if Vendor.Get("Vendor No.") then;
                "Vendor Name" := Vendor.Name;

                ValidateAndUpdateSupplierGroupingData();
            end;
        }
        field(33; "Vendor Name"; text[100])
        {
            Editable = false;
        }
        field(40; No_of_Quotes; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Requisition Quote" WHERE("Request No." = FIELD("Request No."), "Request Line No." = FIELD("Line No.")));
            Editable = false;
        }
        field(50; "Vendor Item No."; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(53; "Approved/Rejected Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60; "Ready for PO"; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(61; "Purchase Doc Created"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Purchase Document Created';
            Editable = false;
        }
        field(62; Comment; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(63; "Selected Quote No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(64; "VAT Prod. Posting Group"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "VAT Product Posting Group";
        }
        field(65; Cancelled; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(70; "Purchase Doc No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Purchase Document No.';
            Editable = false;
            TableRelation = "Purchase Header"."No." where("Document Type" = filter(Order | Invoice));
        }
        field(75; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(8));
        }
        field(80; "Transaction Type"; Enum "Transaction Types")
        {
            DataClassification = CustomerContent;
        }
        field(81; "Total Amount"; Decimal)
        {
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = sum("Purchase Requisition Line"."Amount Excl VAT");
        }
        field(84; RemAmount; Decimal)
        {
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            Caption = 'Remaining Amount';
            CalcFormula = lookup("Vendor Ledger Entry"."Remaining Amount" where("Request No." = field("Request No.")));
        }




    }

    keys
    {
        key(PK; "Request No.", "Line No.")
        {
            Clustered = true;
        }
    }
    var





    trigger OnInsert()
    begin
        TestField("Request No.");
        UpdateHeaderData();
        "Date Created" := Today;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    procedure UpdateHeaderData()
    var
        PurchReqHdr: Record "Purchase Requisition Header";
    begin
        if not PurchReqHdr.Get("Request No.") then
            exit;
        "Employee No." := PurchReqHdr."Employee No.";
        "Employee Name" := PurchReqHdr."Employee Name";
        "Purchase Type" := PurchReqHdr."Purchase Type";
        "Transaction Type" := PurchReqHdr."Transaction Type";
    end;

    local procedure ValidateAndUpdateSupplierGroupingData()
    var
        ReqLine: Record "Purchase Requisition Line";
    begin
        if "Vendor No." = '' then begin
            DeleteSupplierGroupingData("Request No.", xRec."Vendor No.");
            UpdateSupplierGroupingData(xRec."Vendor No.");//update if xVendor having other lines
            exit;
        end else
            TestField("Amount Excl VAT");

        if "Vendor No." <> xRec."Vendor No." then begin
            DeleteSupplierGroupingData("Request No.", xRec."Vendor No.");
            UpdateSupplierGroupingData(xRec."Vendor No.");//update if xVendor having other lines
        end;

        UpdateSupplierGroupingData("Vendor No.");
    end;

    local procedure UpdateSupplierGroupingData(VendorNo: Code[20])
    var
        SuppGrpHdr: Record "Supplier Grouping Header";
        ReqLine: Record "Purchase Requisition Line";
        TotalAmt: Decimal;
        Vendor: Record Vendor;
    begin
        if VendorNo = '' then
            exit;
        ReqLine.reset;
        ReqLine.SetRange("Request No.", "Request No.");
        ReqLine.SetRange("Vendor No.", VendorNo);
        ReqLine.SetFilter("Line No.", '<>%1', "Line No.");
        ReqLine.SetRange("Amount Excl VAT", 0);//Delete if vendor having zero amount lines
        if not ReqLine.IsEmpty() then begin
            DeleteSupplierGroupingData("Request No.", VendorNo);
            exit;
        end;

        ReqLine.reset;
        ReqLine.SetRange("Request No.", "Request No.");
        ReqLine.SetRange("Vendor No.", VendorNo);
        ReqLine.SetFilter("Line No.", '<>%1', "Line No.");
        ReqLine.CalcSums("Amount Excl VAT");
        TotalAmt := ReqLine."Amount Excl VAT";
        if VendorNo = "Vendor No." then
            TotalAmt += "Amount Excl VAT";
        Vendor.get(VendorNo);
        if TotalAmt <> 0 then begin
            SuppGrpHdr.Init();
            SuppGrpHdr."Request No." := "Request No.";
            SuppGrpHdr."Vendor No." := Vendor."No.";
            SuppGrpHdr."Vendor Name" := Vendor.Name;
            SuppGrpHdr."Total Amount" := TotalAmt;
            SuppGrpHdr.Status := SuppGrpHdr.Status::"Pending Approval";
            if not SuppGrpHdr.Insert(true) then
                SuppGrpHdr.Modify(true);
            UpdateRequestApprovalEntries(VendorNo);
        end;
    end;

    local procedure DeleteSupplierGroupingData(ReqNo: Code[20]; VendorNo: Code[20])
    var
        SuppGrpHdr: Record "Supplier Grouping Header";
    begin
        if SuppGrpHdr.Get(ReqNo, VendorNo) then
            SuppGrpHdr.Delete(true);
        DeleteRequestApprovalEntries(ReqNo, VendorNo);
    end;

    local procedure UpdateRequestApprovalEntries(VendorNo: Code[20])
    var
        ReqApprEntry: Record "Request Approval Entry";
        PurchSetup: Record "Purchases & Payables Setup";
        ApprSetup: Record "Web Approval Setup";
        ReqHdr: Record "Purchase Requisition Header";
        SuppGrpHdr: Record "Supplier Grouping Header";
        LoopCount: Integer;
        i: Integer;
    begin
        ReqHdr.Get("Request No.");
        ReqHdr.TestField("Shortcut Dimension 1 Code");
        ReqHdr.TestField("Purchase Type");
        ApprSetup.Get(ReqHdr."Shortcut Dimension 1 Code", ReqHdr."Purchase Type");
        if not (ReqHdr."Employee No." in [ApprSetup.Initiator, ApprSetup."Initiator Delegator"]) then
            Error('Initiator in Request header should be either Initiator or Initiator Delegator from Web Approval Setup.');
        PurchSetup.Get();
        PurchSetup.TestField("Threshold Amount");

        SuppGrpHdr.Get("Request No.", VendorNo);
        if SuppGrpHdr."Total Amount" > PurchSetup."Threshold Amount" then
            ApprSetup.TestField("Level 1 Approval >")
        else
            ApprSetup.TestField("Level 1 Approval <");

        ReqApprEntry.SetRange("Request No.", "Request No.");
        ReqApprEntry.SetRange("Vendor No.", VendorNo);
        ReqApprEntry.SetFilter("Decision Timestamp", '<>%1', 0D);
        if not ReqApprEntry.IsEmpty() then
            Error('Some part of approvals was already done, you cannot change anything now.');

        LoopCount := 1;
        if SuppGrpHdr."Total Amount" > PurchSetup."Threshold Amount" then
            LoopCount := 2;

        For i := 1 to LoopCount do begin
            ReqApprEntry.Init();
            ReqApprEntry."Request No." := "Request No.";
            ReqApprEntry.validate("Vendor No.", VendorNo);
            ReqApprEntry."Approval Level" := i;
            if not ReqApprEntry.Insert(true) then
                ReqApprEntry.Modify(true);
            if i = 1 then begin
                if SuppGrpHdr."Total Amount" < PurchSetup."Threshold Amount" then begin
                    ReqApprEntry."Approver No." := ApprSetup."Level 1 Approval <";
                    ReqApprEntry."Deligate No." := ApprSetup."Level 1 Deligation <";
                end else begin
                    ReqApprEntry."Approver No." := ApprSetup."Level 1 Approval >";
                    ReqApprEntry."Deligate No." := ApprSetup."Level 1 Deligation >";
                end;
            end else begin
                ReqApprEntry."Approver No." := ApprSetup."Level 2 Approval";
                ReqApprEntry."Deligate No." := ApprSetup."Level 2 Deligation";
            end;
            ReqApprEntry."Approver Name" := GetUserName(ReqApprEntry."Approver No.");
            ReqApprEntry."Deligate Name" := GetUserName(ReqApprEntry."Deligate No.");
            ReqApprEntry.Modify(true);
        end;
    end;

    local procedure GetUserName(WebUserId: Code[20]): Text[100]
    var
        WebUser: Record "Web Users";
    begin
        if WebUser.Get(WebUserId) then
            exit(WebUser."First Name" + ' ' + WebUser."Last Name");
        exit('');
    end;

    local procedure DeleteRequestApprovalEntries(ReqNo: Code[20]; VendorNo: Code[20])
    var
        ReqApprEntry: Record "Request Approval Entry";
    begin
        ReqApprEntry.SetRange("Request No.", ReqNo);
        ReqApprEntry.SetRange("Vendor No.", VendorNo);
        ReqApprEntry.DeleteAll(true);
    end;
}