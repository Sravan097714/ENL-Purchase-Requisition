pageextension 50136 PurchaseInvsExt extends "Purchase Invoices"
{
    layout
    {
        // Add changes to page layout here
        addafter(Amount)
        {
            field("Released Date"; Rec."Released Date")
            {
                ApplicationArea = all;
            }
            field("Approver Name"; Rec."Approver Name")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}