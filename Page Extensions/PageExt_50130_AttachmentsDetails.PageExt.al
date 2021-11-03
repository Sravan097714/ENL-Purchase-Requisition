pageextension 50130 DocumentAttachmentDetailsExt extends "Document Attachment Details"
{
    actions
    {
        modify(Preview)
        {
            Caption = 'Download';
        }
        addafter(Preview)
        {
            action(ViewPDF)
            {
                ApplicationArea = All;
                Caption = 'Preview';
                Image = View;
                Enabled = Rec."File Type" = Rec."File Type"::PDF;
                Scope = "Repeater";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.ViewAttachment(false);
                end;
            }

        }
        addlast(Processing)
        {

            action(ViewPDFPopup)
            {
                ApplicationArea = All;
                Caption = 'View in new window';
                Image = View;
                Enabled = Rec."File Type" = Rec."File Type"::PDF;
                Scope = "Repeater";

                trigger OnAction()
                begin
                    Rec.ViewAttachment(true);
                end;
            }
        }
    }
}