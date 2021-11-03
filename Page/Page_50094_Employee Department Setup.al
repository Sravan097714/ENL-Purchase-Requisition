page 50094 "Employee Department Setup"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Employee Department Setup";

    layout
    {
        area(Content)
        {
            repeater(List)
            {
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Department Name"; "Department Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}