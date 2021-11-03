pageextension 50125 PurchInvoiceSubform extends "Purch. Invoice Subform"
{
    layout
    {
        addlast(PurchDetailLine)
        {
            field("Request No."; "Request No.")
            {
                ApplicationArea = All;
            }
            field("Request Line No."; "Request Line No.")
            {
                ApplicationArea = All;
            }

            field(Attachment; Attachment)
            {
                ApplicationArea = All;
                trigger OnDrilldown()
                begin
                    if Attachment <> '' then
                        OpenAttachment();
                end;
            }
            field("Document Link"; Rec."Document Link")
            {
                ApplicationArea = All;
                trigger OnDrilldown()
                begin
                    if "Document Link" <> '' then
                        Hyperlink(Rec."Document Link");
                end;
            }

        }
        modify("IC Partner Ref. Type")
        {
            Visible = false;
        }
        modify("IC Partner Code")
        {
            Visible = false;
        }
        modify("IC Partner Reference")
        {
            Visible = false;
        }



    }

    actions
    {
        // Add changes to page actions here
    }
    local procedure OpenAttachment()
    var
        TempBlob: Codeunit "Temp Blob";
        FileMgt: Codeunit "File Management";
        FileName: Text;
        FileP: File;
        InStr: InStream;
        OutStr: OutStream;
    begin
        if not Exists(Rec.Attachment) then
            exit;
        FileP.Open(Rec.Attachment);
        FileP.CreateInStream(InStr);
        TempBlob.CreateOutStream(OutStr);
        CopyStream(OutStr, InStr);
        FileName := FileMgt.GetFileName(Rec.Attachment);
        FileP.Close();
        FileName := FileMgt.BLOBExport(TempBlob, FileName, TRUE);
    end;
}