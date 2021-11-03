pageextension 50135 VendorLedgerEntryExt extends 29
{
    layout
    {
        addafter("External Document No.")
        {
            field("Request No."; "Request No.")
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