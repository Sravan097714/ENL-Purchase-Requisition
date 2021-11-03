page 50107 Staff
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = Staff;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
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