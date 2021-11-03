pageextension 50128 PurchaseOrderList extends "Purchase Order List"
{
    layout
    {
        addafter(Amount)
        {
            field("WebApprover"; "Web Approver")
            {
                ApplicationArea = all;
            }
            field("PurchaserCode"; "Purchaser Code")
            {
                ApplicationArea = all;
            }
            field("PostingDescription"; "Posting Description")
            {
                ApplicationArea = all;
            }
            field("CurrencyCode"; "Currency Code")
            {
                ApplicationArea = all;
            }
            field("PostingDate"; "Posting Date")
            {
                ApplicationArea = all;
            }
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Vendor Authorization No.")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
        addafter(WebApprover)
        {
            /*  field(Archive; Archive)
             {
                 ApplicationArea = all;
                 Editable = true;
             } */
        }
    }

    actions
    {
        /* addafter(PostBatch)
        {
            action("Archive Document")
            {
                ApplicationArea = Suite;
                Caption = 'Archive Document';
                Ellipsis = true;
                Image = Archive;
                Promoted = true;
                PromotedCategory = Category8;
                ToolTip = 'Archive several documents at once';

                trigger OnAction()
                var
                    PurchHeaderLRec: Record "Purchase Header";
                    ArchiveManagement: Codeunit ArchiveManagement;
                begin
                    //Rec."Archive Version No." := 1;
                    ArchiveManagement.ArchivePurchDocument(Rec);
                    CurrPage.UPDATE(FALSE);
                    Rec."Archive Version No." := 1;
                end;
            }
        } */

    }
}