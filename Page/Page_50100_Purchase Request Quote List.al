page 50100 "Purchase Request Quote List"
{
    PageType = List;
    Editable = false;
    SourceTable = "Purchase Requisition Quote";
    UsageCategory = Tasks;
    Caption = 'Purchase Request Quote List';
    ApplicationArea = All;
    CardPageId = "Purchase Requisition Quote WS";
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Quote No."; "Quote No.")
                {
                    ApplicationArea = All;
                }
                field("Request No."; "Request No.")
                {
                    ApplicationArea = All;
                }
                field("Request Line No."; "Request Line No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Remarks)
                {
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
                }
                field("Expected Delivery Date"; "Expected Delivery Date")
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
                field("Vendor Contact"; "Vendor Contact")
                {
                    ApplicationArea = All;
                }
                field("Vendor Phone No."; "Vendor Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Item Reference"; "Vendor Item Reference")
                {
                    ApplicationArea = All;
                }
                field("Vendor Quote No."; "Vendor Quote No.")
                {
                    ApplicationArea = All;
                }
                field(Selected; Selected)
                {
                    ApplicationArea = All;
                }
                field("Date Selected"; "Date Selected")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}