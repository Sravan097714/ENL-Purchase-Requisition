page 50096 "Purchase Requisition WS"
{
    PageType = Document;
    SourceTable = "Purchase Requisition Header";
    SourceTableView = sorting("Date of Request") order(descending);


    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Request No."; "Request No.")
                {
                    ApplicationArea = All;
                    AssistEdit = true;
                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Date of Request"; "Date of Request")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        UpdateControls();
                    end;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Updatedescription();

                    end;

                }
                field("ShortcutDimension 2 Name"; "ShortcutDimension 2 Name")
                {
                    ApplicationArea = all;
                    Caption = 'Shortcut Dimension 2 Name';
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
                    trigger OnValidate()
                    begin
                        UpdateControls();
                    end;
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
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                }
                field("Approval Limit"; "Approval Limit")
                {
                    ApplicationArea = All;
                }
                field("Approval Request Date"; "Approval Request Date")
                {
                    ApplicationArea = All;
                }
                field("Web Link"; "Web Link")
                {
                    ApplicationArea = All;
                }
                field("Copy Date"; "Copy Date")
                {
                    ApplicationArea = All;
                }
                field(RequestedBy; RequestedBy)
                {
                    ApplicationArea = All;
                }
                field("Validation Date"; "Validation Date")
                {
                    ApplicationArea = All;
                }
                field(VendorInvNo; VendorInvNo)
                {
                    ApplicationArea = all;
                    Caption = 'Vendor Invoice No.';
                }
                field("Currency Code"; "Currency Code")
                {
                    Caption = 'Currency Code';
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                    Caption = 'Description';
                }
                field(Totalamount; Totalamount)
                {
                    ApplicationArea = all;
                    Caption = 'Total Amount';
                    Editable = false;
                }


            }
            part(Lines; "Purchase Requisition Subform")
            {
                Caption = 'Lines';
                ApplicationArea = All;
                SubPageLink = "Request No." = FIELD("Request No.");
                UpdatePropagation = Both;
            }
        }
    }

    var
        DeptName: Text[50];
        PurchTypeDesc: Text[50];

    trigger OnAfterGetRecord()
    begin
        UpdateControls();
    end;

    local procedure UpdateControls()
    var
        GLSetup: Record "General Ledger Setup";
        DimVal: Record "Dimension Value";
        PurchTypes: Record "Purchase Types";
    begin
        GLSetup.get();
        DimVal.Reset();
        DimVal.SetRange("Dimension Code", GLSetup."Shortcut Dimension 1 Code");
        DimVal.SetRange(Code, "Shortcut Dimension 1 Code");
        if not DimVal.FindFirst() then
            Clear(DimVal);
        DeptName := DimVal.Name;

        if not PurchTypes.Get("Purchase Type") then
            Clear(PurchTypes);
        PurchTypeDesc := PurchTypes.Description;
    end;

    local procedure Updatedescription()
    var
        GLSetup: Record "General Ledger Setup";
        DimVal: Record "Dimension Value";
    begin
        GLSetup.get();
        DimVal.Reset();
        DimVal.SetRange("Dimension Code", GLSetup."Shortcut Dimension 2 Code");
        DimVal.SetRange(Code, "Shortcut Dimension 2 Code");
        if not DimVal.FindFirst() then
            Clear(DimVal);
        "ShortcutDimension 2 Name" := DimVal.Name;

    end;
}
