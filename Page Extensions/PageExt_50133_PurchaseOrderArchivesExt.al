pageextension 50133 PurchaseOrderArchivesExt extends "Purchase Order Archives"
{
    layout
    {
        addafter("Location Code")
        {
            /* field(Archive; Archive)
            {
                ApplicationArea = all;
                Caption = 'Archive';
            } */
        }
    }

    actions
    {
        /* addafter("Delete Order Versions")
        {
            action("Restore Order")
            {
                ApplicationArea = Suite;
                Caption = 'Restore Order';
                Ellipsis = true;
                Image = Archive;
                Promoted = true;
                PromotedCategory = Category8;
                ToolTip = 'Restore several documents at once';

                trigger OnAction()
                var
                    PurchaseHeader: Record "Purchase Header";
                    ArchiveManagement: Codeunit ArchiveManagement;
                    PurchHeaderArchive: Record "Purchase Header Archive";
                begin
                    CurrPage.SETSELECTIONFILTER(PurchHeaderArchive);
                    IF PurchHeaderArchive.FINDSET THEN BEGIN
                        REPEAT
                            PurchaseHeader.GET(PurchHeaderArchive."Document Type", PurchHeaderArchive."No.");
                            PurchaseHeader.TESTFIELD("Archive Version No.", PurchHeaderArchive."Version No.");
                            PurchaseHeader."Archive Version No." := 0;
                            PurchaseHeader."Last Restored Archive Version" := "Version No.";
                            PurchaseHeader.MODIFY;
                            PurchHeaderArchive.Restored := TRUE;
                            PurchHeaderArchive.MODIFY;
                        UNTIL PurchHeaderArchive.NEXT = 0;
                        MESSAGE('Restore Done');
                    END;
                end;
            }
        } */
    }

    var
        myInt: Integer;
}