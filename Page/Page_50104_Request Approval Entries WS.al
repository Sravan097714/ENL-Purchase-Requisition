page 50104 "Request Approval Entries WS"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Request Approval Entry";
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(List)
            {
                field("Request No."; "Request No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Vendor No."; "Vendor No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Approval Level"; "Approval Level")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Approver No."; "Approver No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Approver Name"; "Approver Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Deligate No."; "Deligate No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Deligate Name"; "Deligate Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Use Deligate"; "Use Deligate")
                {
                    ApplicationArea = All;
                }
                field(Comment; Comment)
                {
                    ApplicationArea = All;
                }
                field(Decision; Decision)
                {
                    ApplicationArea = All;
                }
                field("Decision Timestamp"; "Decision Timestamp")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}