page 50106 "Purchase Requests (PO Created)"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    SourceTable = "Purchase Requisition Line";
    SourceTableView = where("Ready for PO" = const(true), "Purchase Doc Created" = const(true), "Transaction Type" = const(Order), Cancelled = const(false));
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
                field("Purchase Doc No."; Rec."Purchase Doc No.")
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
                    Editable = false;
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
            }
        }
    }
    var
        RequestHdr: Record "Purchase Requisition Header";
        DeptName: Text[50];
        PurchTypeDesc: Text[50];
        Approver1: Code[20];
        Approver2: Code[20];
        Approver1Name: Text[50];
        Approver2Name: Text[50];
        SupplierGrouping: Record "Supplier Grouping Header";

    trigger OnAfterGetRecord()
    begin
        RequestHdr.Get("Request No.");
        if not SupplierGrouping.Get("Request No.", "Vendor No.") then
            Clear(SupplierGrouping);
        UpdateControls();
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
}