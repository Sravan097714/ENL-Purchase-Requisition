pageextension 50127 ChartofAccountsExt extends 16
{
    layout
    {
        addafter("Income/Balance")
        {
            field("Purchase Type"; "Purchase Type")
            {
                ApplicationArea = all;
            }
        }
        modify(Control1)
        {
            FreezeColumn = Name;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}