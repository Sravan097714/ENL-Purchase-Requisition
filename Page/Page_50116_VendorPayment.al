page 50116 "VendorPayment Approval Cue"
{
    Caption = 'Approval - Vendor';
    PageType = CardPart;
    RefreshOnActivate = true;
    ShowFilter = false;
    SourceTable = VendorPayment;

    layout
    {
        area(content)
        {
            cuegroup(Approvals)
            {
                Caption = 'Supplier Payments';


                field(Approved; Approved)
                {
                    ApplicationArea = Suite;
                    DrillDownPageID = "Approval Entries";
                    ToolTip = 'Approved';
                }
                field(Canceled; Canceled)
                {
                    ApplicationArea = Suite;
                    DrillDownPageID = "Approval Entries";
                    ToolTip = 'Canceled';
                }
                field(Created; Created)
                {
                    ApplicationArea = Suite;
                    DrillDownPageID = "Approval Entries";
                    ToolTip = 'Created';
                    Visible = false;
                }
                field(Open; Open)
                {
                    ApplicationArea = Suite;
                    DrillDownPageID = "Approval Entries";
                    ToolTip = 'Open';
                }
                field(Rejected; Rejected)
                {
                    ApplicationArea = Suite;
                    DrillDownPageID = "Approval Entries";
                    ToolTip = 'Rejected';
                }
                field("All Approved Payment"; "All Approved Payments")
                {
                    ApplicationArea = suite;
                    DrillDownPageId = "Approval Entries";
                    Tooltip = 'All Approved Payments';
                }
                field("All Pending Payments"; "All Pending Payments")
                {
                    ApplicationArea = suite;
                    DrillDownPageId = ApprovalEntriesBasePageAppOp;
                    Tooltip = 'All Pending Payments';
                }




            }
        }

    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Reset();
        if not Get() then begin
            Init();
            Insert();
        end;
        SetRange("User ID Filter", UserId);
    end;
}