pageextension 50124 PurchOrderSubform extends "Purchase Order Subform"
{
    layout
    {
        addlast(Control1)
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
        modify("Location Code")
        {
            Visible = false;
        }
        addafter("VAT Prod. Posting Group")
        {
            field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
            {
                ApplicationArea = all;
            }
        }
        modify("Bin Code")
        {
            Visible = false;
        }
        modify("Reserved Quantity")
        {
            Visible = false;
        }
        modify("Unit of Measure")
        {
            Visible = false;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Tax Group Code")
        {
            Visible = false;
        }
        modify("Promised Receipt Date")
        {
            Visible = false;
        }
        modify("Planned Receipt Date")
        {
            Visible = false;
        }
        modify("Expected Receipt Date")
        {
            Visible = false;
        }
        modify("Over-Receipt Quantity")
        {
            Visible = false;
        }
        modify("Over-Receipt Code")
        {
            Visible = false;
        }
        modify("Qty. Assigned")
        {
            Visible = false;
        }
        modify("Qty. to Assign")
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
        //FileName := FileMgt.GetFileNameWithoutExtension(FileName);
        FileP.Close();
        FileName := FileMgt.BLOBExport(TempBlob, FileName, TRUE);
    end;
}