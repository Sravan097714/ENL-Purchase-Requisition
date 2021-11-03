
//Added By Cedric Dominique - 07.06.2021
pageextension 50126 "Purchase Invoice" extends "Purchase Invoice"
{
    layout
    {
        addafter("Buy-from Vendor No.")
        {
            field("Request No."; "Request No.")
            {
                ApplicationArea = All;
            }
            field(Iniator; Iniator)
            {
                ApplicationArea = all;
            }
            field("Web Approver"; "Web Approver")
            {
                ApplicationArea = all;
            }
        }

        addafter("Posting Date")
        {
            field(VendorInv_No; VendorInv_No)
            {
                ApplicationArea = all;
            }
            field(ShortcutDimension2Code; ShortcutDimension2Code)
            {
                ApplicationArea = all;
            }
        }
        addafter(Status)
        {
            field("PostingDescription"; "Posting Description")
            {
                ApplicationArea = all;
                ShowMandatory = NOT IsBlank;
            }
        }
    }
    var
        IsBlank: Boolean;
}
//End By Cedric Dominique - 07.06.2021