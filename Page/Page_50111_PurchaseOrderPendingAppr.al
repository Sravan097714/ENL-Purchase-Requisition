page 50111 "PurchaseOrdersPending Approval"
{
    Caption = 'Approval - Purchase Orders';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = PurchaseOrderPendingAppr;

    layout
    {
        area(content)
        {
            cuegroup(Purchases)
            {
                Caption = 'Purchase';
                field("Purchase Orders Pending Approval"; PurchaseOrderPending)
                {
                    ApplicationArea = Suite;
                    DrillDownPageID = "Purchase Order List";
                    ToolTip = 'Specifies the number of purchase orders that are pending approval.';

                }
                field("Purchase Invoices Pending Approval"; "PurchaseInvPending")
                {
                    ApplicationArea = Suite;
                    DrillDownPageID = "Purchase Invoices";

                }


            }
            cuegroup("Purchase Requests")
            {
                Caption = 'Purchase Requests';
                field("Purchase Requests Ready For PO"; "Purchase Request Ready For PO")
                {
                    ApplicationArea = Suite;
                    DrillDownPageID = "Purch Requests (Ready for PO)";

                }
                field("Purchase Requests Ready For PI"; "Purchase Request Ready For PI")
                {
                    ApplicationArea = Suite;
                    DrillDownPageID = "Purchase Request Invoice";

                }
                field("Purchase Requests Cancelled"; "Purchase Request Cancelled")
                {
                    ApplicationArea = Suite;
                    DrillDownPageID = "Purchase Request";

                }


            }
        }

    }




}