page 50090 "Web Users WS"
{
    PageType = List;
    SourceTable = "Web Users";
    UsageCategory = Administration;
    ApplicationArea = All;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field("First Name"; "First Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; "Last Name")
                {
                    ApplicationArea = All;
                }
                field("Web User Name"; "Web User Name")
                {
                    ApplicationArea = All;
                }
                field(Password; Password)
                {
                    ApplicationArea = All;
                }
                field(Email; Email)
                {
                    ApplicationArea = All;
                }
                field("Lock TS"; "Lock TS")
                {
                    ApplicationArea = All;
                }
                field("Admin TS"; "Admin TS")
                {
                    ApplicationArea = All;
                }
                field("Last Password Change"; "Last Password Change")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}