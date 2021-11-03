page 50097 "Purchase Requisition Subform"
{
    PageType = ListPart;
    SourceTable = "Purchase Requisition Line";
    DelayedInsert = true;
    MultipleNewLines = true;
    AutoSplitKey = true;
    LinksAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Request No."; "Request No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    trigger OnValidate()
                    begin
                        UpdateHeaderData();
                    end;
                }
                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    trigger OnValidate()
                    begin
                        UpdateHeaderData();
                    end;
                }
                field("Date Created"; "Date Created")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        UpdateHeaderData();
                    end;
                }
                field("G/L Account No."; "G/L Account No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("VAT Prod Posting Group"; "VAT Prod. Posting Group")
                {
                    Caption = 'VAT Prod. Posting Group';
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; "Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Amount Excl VAT"; "Amount Excl VAT")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Expected Delivery Date"; "Expected Delivery Date")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 8 Code"; Rec."Shortcut Dimension 8 Code")
                {
                    ApplicationArea = All;
                }
                field("Vendor No."; "Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Name"; "Vendor Name")
                {
                    ApplicationArea = All;
                }
                field(No_of_Quotes; No_of_Quotes)
                {
                    ApplicationArea = All;
                }
                field("Vendor Item No."; "Vendor Item No.")
                {
                    ApplicationArea = All;
                }
                field(Comment; Comment)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Approved/Rejected Date"; "Approved/Rejected Date")
                {
                    ApplicationArea = All;
                }
                field("Selected Quote No."; "Selected Quote No.")
                {
                    ApplicationArea = All;
                }

            }
        }
    }
    var
        totalamount: Decimal;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UpdateHeaderData();
    end;


}