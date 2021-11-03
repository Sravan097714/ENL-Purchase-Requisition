page 50101 "G/L Account Dropdown WS"
{
    PageType = List;
    Editable = false;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "G/L Account";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Purchase Type"; "Purchase Type")
                {
                    ApplicationArea = All;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}