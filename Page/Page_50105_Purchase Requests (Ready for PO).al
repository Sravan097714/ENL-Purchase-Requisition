page 50105 "Purch Requests (Ready for PO)"
{
    Caption = 'Purchase Requests (Ready to Create PO)';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Purchase Requisition Line";
    SourceTableView = where("Ready for PO" = const(true), "Purchase Doc Created" = const(false), "Transaction Type" = const(Order), Cancelled = const(false));
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(List)
            {
                field("Request No."; "Request No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Date Created"; "Date Created")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("G/L Account No."; "G/L Account No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("VAT Prod. Posting Group"; "VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Unit Price"; "Unit Price")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Amount Excl VAT"; "Amount Excl VAT")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Cancelled; Cancelled)
                {
                    ApplicationArea = All;
                }
                field("Expected Delivery Date"; "Expected Delivery Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 8 Code"; Rec."Shortcut Dimension 8 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Vendor No."; "Vendor No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Vendor Name"; "Vendor Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Shortcut Dimension 1 Code"; RequestHdr."Shortcut Dimension 1 Code")
                {
                    CaptionClass = '1,2,1';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(DeptName; DeptName)
                {
                    ApplicationArea = All;
                    Caption = 'Department Name';
                    Editable = false;
                }
                field("Purchase Type"; "Purchase Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(PurchTypeDesc; PurchTypeDesc)
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Type Description';
                    Editable = false;
                }
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Approver1; Approver1)
                {
                    Caption = 'Approver 1';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Approver1Name; Approver1Name)
                {
                    Caption = 'Name';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Approver2; Approver2)
                {
                    Caption = 'Approver 2';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Approver2Name; Approver2Name)
                {
                    Caption = 'Name';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status; SupplierGrouping.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Vendor Item No."; "Vendor Item No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Comment; Comment)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Approved/Rejected Date"; "Approved/Rejected Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(currencycode; RequestHdr."Currency Code")
                {
                    Caption = 'Currency Code';
                    ApplicationArea = all;
                    Editable = false;
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Create Purchase Document")
            {
                ApplicationArea = All;
                Image = CreateDocument;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction();
                begin
                    CreatePurchDocument();
                    CurrPage.Update(false);
                end;
            }
            action(Cancel)
            {
                ApplicationArea = All;
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    ReqLine: Record "Purchase Requisition Line";
                begin
                    CurrPage.SetSelectionFilter(ReqLine);
                    if ReqLine.FindSet() then
                        ReqLine.ModifyAll(Cancelled, true);
                    CurrPage.Update(false);
                end;
            }
        }
    }

    var
        RequestHdr: Record "Purchase Requisition Header";
        SupplierGrouping: Record "Supplier Grouping Header";
        DeptName: Text[50];
        PurchTypeDesc: Text[50];
        Approver1: Code[20];
        Approver2: Code[20];
        Approver1Name: Text[50];
        Approver2Name: Text[50];
        currencycode: Option;

    trigger OnAfterGetRecord()
    begin
        RequestHdr.Get("Request No.");
        if not SupplierGrouping.Get("Request No.", "Vendor No.") then
            Clear(SupplierGrouping);
        UpdateControls();

        RequestHdr.Reset();
        RequestHdr.SetRange("Request No.", "Request No.");
        if RequestHdr.FindFirst
        then
            currencycode := RequestHdr."Currency Code";
    end;

    local procedure UpdateControls()
    var
        GLSetup: Record "General Ledger Setup";
        DimVal: Record "Dimension Value";
        PurchTypes: Record "Purchase Types";
        ReqApprEntry: Record "Request Approval Entry";
    begin
        GLSetup.get();
        DimVal.Reset();
        DimVal.SetRange("Dimension Code", GLSetup."Shortcut Dimension 1 Code");
        DimVal.SetRange(Code, RequestHdr."Shortcut Dimension 1 Code");
        if not DimVal.FindFirst() then
            Clear(DimVal);
        DeptName := DimVal.Name;

        if not PurchTypes.Get("Purchase Type") then
            Clear(PurchTypes);
        PurchTypeDesc := PurchTypes.Description;

        Clear(Approver1);
        Clear(Approver1Name);
        Clear(Approver2);
        Clear(Approver2Name);
        ReqApprEntry.Reset();
        ReqApprEntry.SetRange("Request No.", "Request No.");
        ReqApprEntry.SetRange("Vendor No.", "Vendor No.");
        ReqApprEntry.SetRange(Decision, true);
        if ReqApprEntry.FindSet() then
            repeat
                case ReqApprEntry."Approval Level" of
                    1:
                        begin
                            if ReqApprEntry."Use Deligate" then begin
                                Approver1 := ReqApprEntry."Deligate No.";
                                Approver1Name := ReqApprEntry."Deligate Name";
                            end else begin
                                Approver1 := ReqApprEntry."Approver No.";
                                Approver1Name := ReqApprEntry."Approver Name";
                            end;
                        end;
                    2:
                        begin
                            if ReqApprEntry."Use Deligate" then begin
                                Approver2 := ReqApprEntry."Deligate No.";
                                Approver2Name := ReqApprEntry."Deligate Name";
                            end else begin
                                Approver2 := ReqApprEntry."Approver No.";
                                Approver2Name := ReqApprEntry."Approver Name";
                            end;
                        end;
                end;
            until ReqApprEntry.Next() = 0;
    end;

    procedure CreatePurchDocument()
    var
        ReqLine: Record "Purchase Requisition Line";
        ReqLine2: Record "Purchase Requisition Line";
        ReqHeader: Record "Purchase Requisition Header";//Added By Cedric Dominique - 04.06.2021
        ReqApprovalEntryRec: Record "Request Approval Entry";//Added By Cedric Dominique - 04.06.2021 
        PurchHdr: Record "Purchase Header";
        PurchHdr2: Record "Purchase Header";
        PurchCatInitiator: Record "Purchase Category Initiator";
        NoSeriesMgmt: Codeunit NoSeriesManagement;
        PrevVendorNo: Code[20];
        PrevRequestNo: Code[20];
        PurchDocNo: Code[20];
        LineNo: Integer;
        MultiReqFound: Boolean;
        ExitLoop: Boolean;
        ConfirmTxt: Label 'More than one request selected to create Purchase document, do you want to proceed?';
        POCreatedTxt: Label 'Purchase %4 %1 is created for Request %2 and Vendor %3.';
    begin
        CurrPage.SetSelectionFilter(ReqLine2);
        ReqLine2.SetCurrentKey("Request No.", "Vendor No.");
        ReqLine2.SetRange("Ready for PO", true);
        ReqLine2.SetRange("Purchase Doc Created", false);
        ReqLine2.SetRange(Cancelled, false);
        if ReqLine2.FindSet() then
            repeat
                if ReqLine2."Transaction Type" = ReqLine2."Transaction Type"::" " then
                    ReqLine2.FieldError("Transaction Type");

                if PrevRequestNo = '' then
                    PrevRequestNo := ReqLine2."Request No.";
                MultiReqFound := PrevRequestNo <> ReqLine2."Request No.";
            until (ReqLine2.Next() = 0) or MultiReqFound;

        if MultiReqFound then
            if not Confirm(ConfirmTxt, false) then
                exit;
        Clear(PrevRequestNo);
        Clear(PrevVendorNo);
        CurrPage.SetSelectionFilter(ReqLine);
        ReqLine.SetCurrentKey("Request No.", "Vendor No.");
        ReqLine.SetFilter("Vendor No.", '<>%1', '');
        ReqLine.SetRange("Ready for PO", true);
        ReqLine.SetRange("Purchase Doc Created", false);
        ReqLine.SetRange(Cancelled, false);
        if ReqLine.FindSet() then begin
            repeat
                if (PrevRequestNo <> ReqLine."Request No.") or (PrevVendorNo <> ReqLine."Vendor No.")
                then begin
                    if PrevRequestNo <> '' then
                        Message(POCreatedTxt, PurchHdr."No.", PrevRequestNo, PrevVendorNo);
                    Clear(PurchDocNo);
                    if PurchCatInitiator.Get(ReqLine."Purchase Type", ReqLine."Employee No.") then
                        if ReqLine."Transaction Type" = ReqLine."Transaction Type"::Order then begin
                            if PurchCatInitiator."Purchase Order Nos." <> '' then
                                PurchDocNo := NoSeriesMgmt.GetNextNo(PurchCatInitiator."Purchase Order Nos.", 0D, TRUE);
                        end else
                            if ReqLine."Transaction Type" = ReqLine."Transaction Type"::Invoice then
                                if PurchCatInitiator."Purchase Invoice Nos." <> '' then
                                    PurchDocNo := NoSeriesMgmt.GetNextNo(PurchCatInitiator."Purchase Invoice Nos.", 0D, TRUE);

                    PurchHdr.Reset();
                    PurchHdr.Init();
                    if ReqLine."Transaction Type" = ReqLine."Transaction Type"::Order then
                        PurchHdr."Document Type" := PurchHdr."Document Type"::Order
                    else
                        if ReqLine."Transaction Type" = ReqLine."Transaction Type"::Invoice then
                            PurchHdr."Document Type" := PurchHdr."Document Type"::Invoice;
                    PurchHdr."No." := PurchDocNo;
                    PurchHdr.Iniator := ReqLine."Employee Name"; //Added By Cedric Dominique - 04.06.2021
                    PurchHdr.Insert(true);
                    PurchHdr.validate("Buy-from Vendor No.", ReqLine."Vendor No.");
                    if not MultiReqFound then begin
                        PurchHdr."Request No." := ReqLine."Request No.";
                        PurchHdr."Dimension Set ID" := GetDimSetId(PurchHdr."Dimension Set ID", ReqLine."Shortcut Dimension 8 Code");
                    end;
                    //Start Modification - Cedric Dominique - 04.06.2021
                    ReqApprovalEntryRec.SetRange("Request No.", ReqLine."Request No.");
                    if ReqApprovalEntryRec.FindFirst() then begin
                        if ReqApprovalEntryRec."Use Deligate" then
                            PurchHdr.Validate("Web Approver", ReqApprovalEntryRec."Deligate Name")
                        else
                            PurchHdr.Validate("Web Approver", ReqApprovalEntryRec."Approver Name");
                    end;

                    if ReqHeader.Get(ReqLine."Request No.") then PurchHdr.Validate("Purchaser Code", ReqHeader.RequestedBy);
                    //if ReqHeader.Get(ReqLine."Request No.") then PurchHdr.Validate("Currency Code", Format(ReqHeader."Currency Code"));
                    //End Modification - Cedric Dominique - 04.06.2021
                    if ReqHeader.Get(ReqLine."Request No.") then begin
                        if (ReqHeader."Currency Code") <> 0 then
                            PurchHdr.Validate("Currency Code", Format(ReqHeader."Currency Code"));
                    end;

                    PurchHdr.Modify(true);
                    LineNo := 0;

                    PurchHdr2.Get(PurchHdr."Document Type", PurchHdr."No.");
                    PurchHdr2.Mark(true);

                    PrevRequestNo := ReqLine."Request No.";
                    PrevVendorNo := ReqLine."Vendor No.";
                end;
                LineNo += 10000;
                CreatePurchLine(ReqLine, PurchHdr, LineNo);
                ReqLine2.Get(ReqLine."Request No.", ReqLine."Line No.");
                ReqLine2."Purchase Doc Created" := true;
                ReqLine2."Purchase Doc No." := PurchHdr."No.";
                ReqLine2.Modify();
            until ReqLine.Next() = 0;

            if PurchHdr."No." <> '' then
                Message(POCreatedTxt, PurchHdr."No.", ReqLine2."Request No.", ReqLine2."Vendor No.", ReqLine2."Transaction Type");

            PurchHdr2.MarkedOnly(true);
            //if PurchHdr2.FindSet() then
            //PurchHdr2.ModifyAll(Status, PurchHdr2.Status::Released, true);
        end;
    end;

    local procedure CreatePurchLine(ReqLine: Record "Purchase Requisition Line"; PurchHdr: Record "Purchase Header"; var LineNo: Integer)
    var
        PurchLine: Record "Purchase Line";
        ReqHdr: Record "Purchase Requisition Header";
        RequestQuote: Record "Purchase Requisition Quote";
        VendorRec: Record Vendor;//Add by Cedric Dominique 10.06.2021
    begin
        PurchLine.Reset();
        PurchLine.Init();
        PurchLine."Document Type" := PurchHdr."Document Type";
        PurchLine."Document No." := PurchHdr."No.";
        PurchLine."Line No." := LineNo;
        PurchLine.Insert(true);
        PurchLine.Validate(Type, PurchLine.Type::"G/L Account");
        PurchLine.Validate("No.", ReqLine."G/L Account No.");
        PurchLine.validate(Quantity, ReqLine.Quantity);
        PurchLine.Validate("Direct Unit Cost", ReqLine."Unit Price");
        PurchLine.Validate("VAT Prod. Posting Group", ReqLine."VAT Prod. Posting Group");
        ReqHdr.Get(ReqLine."Request No.");
        PurchLine."Amount Including VAT" := (((15 / 100) * "Amount Excl VAT") + "Amount Excl VAT");
        PurchLine.Validate("Shortcut Dimension 1 Code", ReqHdr."Shortcut Dimension 1 Code");
        if RequestQuote.Get(ReqLine."Selected Quote No.") then begin
            PurchLine."Request No." := ReqLine."Request No.";
            PurchLine."Request Line No." := ReqLine."Line No.";
            PurchLine.Attachment := RequestQuote.Attachment;
            PurchLine."Document Link" := RequestQuote.Comment;
            AddDocumentAttachment(PurchHdr, PurchLine);
        end;
        if ReqLine.Description <> '' then
            PurchLine.Description := ReqLine.Description;
        PurchLine."Dimension Set ID" := GetDimSetId(PurchLine."Dimension Set ID", ReqLine."Shortcut Dimension 8 Code");
        //Start Modification Cedric Dominique 04.06.2021
        if VendorRec.get(PurchHdr."Buy-from Vendor No.") then begin
            if VendorRec."VAT Bus. Posting Group" = 'LSUPVAT' then
                PurchLine."VAT Prod. Posting Group" := 'VAT'
            else
                PurchLine."VAT Prod. Posting Group" := 'NVAT';
        end;
        PurchLine."Gen. Prod. Posting Group" := 'SERVICES';
        //End Modification Cedric Dominique 04.06.2021
        PurchLine.Modify(true);
    end;

    local procedure AddDocumentAttachment(PurchHdr: Record "Purchase Header"; PurchLine: Record "Purchase Line")
    var
        Tempblob: Record TempBlob temporary;
        DocumentAttachment: Record "Document Attachment";
        DocStream: InStream;
        RecRef: RecordRef;
    begin
        if PurchLine.Attachment <> '' then begin // +Cedric Dominique - 29.06.2021
            RecRef.GetTable(PurchHdr);
            Tempblob.DeleteAll();
            Tempblob.Blob.Import(PurchLine.Attachment);
            Tempblob.Blob.CreateInStream(DocStream);
            DocumentAttachment.SaveAttachmentFromStream(DocStream, RecRef, PurchLine.Attachment);
        end; // +Cedric Dominique - 29.06.2021
    end;

    local procedure GetDimSetId(OldDimSetId: Integer; DimValueCode8: Code[20]): Integer
    var
        DimSetEntry: Record "Dimension Set Entry";
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
        DimMgt: Codeunit DimensionManagement;
        GLSetup: Record "General Ledger Setup";
    begin
        if DimValueCode8 = '' then
            exit(OldDimSetId);
        GLSetup.Get();
        TempDimSetEntry.DELETEALL;
        DimSetEntry.RESET;
        DimSetEntry.SETRANGE("Dimension Set ID", OldDimSetId);
        IF DimSetEntry.FINDSET THEN
            REPEAT
                IF NOT (DimSetEntry."Dimension Code" IN [GLSetup."Shortcut Dimension 8 Code"]) THEN BEGIN
                    TempDimSetEntry.INIT;
                    TempDimSetEntry.TRANSFERFIELDS(DimSetEntry);
                    TempDimSetEntry.INSERT;
                END;
            UNTIL DimSetEntry.NEXT = 0;

        TempDimSetEntry.INIT;
        TempDimSetEntry.VALIDATE("Dimension Code", GLSetup."Shortcut Dimension 8 Code");
        TempDimSetEntry.VALIDATE("Dimension Value Code", DimValueCode8);
        TempDimSetEntry.INSERT;
        EXIT(DimMgt.GetDimensionSetID(TempDimSetEntry));
    end;
}