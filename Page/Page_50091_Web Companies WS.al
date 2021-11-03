page 50091 "Web Companies WS"
{
    PageType = List;
    SourceTable = "Web User Access";
    UsageCategory = Administration;
    ApplicationArea = All;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Web User No."; "Web User No.")
                {
                    ApplicationArea = All;
                }
                field("Company Name"; "Company Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}