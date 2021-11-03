page 50110 Dimension2Dropdown
{
    PageType = List;
    Editable = false;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Dimension Value";
    SourceTableView = where("Global Dimension No." = const(2));
    //"Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Code; Code)
                {
                    ApplicationArea = all;
                }
                field(Name; Name) { ApplicationArea = all; }
                field("Dimension Code"; "Dimension Code")
                {
                    ApplicationArea = all;
                }

            }
        }
    }

}