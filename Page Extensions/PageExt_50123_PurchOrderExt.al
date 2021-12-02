pageextension 50123 PurchOrderExtPR extends "Purchase Order"
{
    layout
    {

        addafter("Buy-from Vendor No.")
        {
            field("Request No."; "Request No.")
            {
                ApplicationArea = All;
            }
            //Added By Cedric Dominique - 04.06.2021
            field(Iniator; Iniator)
            {
                ApplicationArea = all;
            }
            field("Web Approver"; "Web Approver")
            {
                ApplicationArea = all;

            }
            //End By Cedric Dominique - 04.06.2021


        }
        addafter("Posting Description")
        {
            field("Approver Name"; Rec."Approver Name")
            {
                ApplicationArea = all;
            }
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify("Purchaser Code")
        {
            Caption = 'Department Approver';
        }
    }
    actions
    {
        /* addafter(PostAndNew)
        {
            action("ArchiveDocument")
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