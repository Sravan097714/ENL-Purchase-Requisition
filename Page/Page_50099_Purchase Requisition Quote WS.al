page 50099 "Purchase Requisition Quote WS"
{
    PageType = Card;
    SourceTable = "Purchase Requisition Quote";
    layout
    {
        area(Content)
        {
            group(Group)
            {
                field("Quote No."; "Quote No.")
                {
                    ApplicationArea = All;
                }
                field("Request No."; "Request No.")
                {
                    ApplicationArea = All;
                }
                field("Request Line No."; "Request Line No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; "Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Amount Excl VAT"; "Amount Excl VAT")
                {
                    ApplicationArea = All;
                }
                field("Expected Delivery Date"; "Expected Delivery Date")
                {
                    ApplicationArea = All;
                }
                field("Vendor No."; "Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Name"; "Vendor Name")
                {
                    ApplicationArea = All;
                }
                field("Vendor Contact"; "Vendor Contact")
                {
                    ApplicationArea = All;
                }
                field("Vendor Phone No."; "Vendor Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Item Reference"; "Vendor Item Reference")
                {
                    ApplicationArea = All;
                }
                field("Vendor Quote No."; "Vendor Quote No.")
                {
                    ApplicationArea = All;
                }
                field(Selected; Selected)
                {
                    ApplicationArea = All;
                }
                field("Date Selected"; "Date Selected")
                {
                    ApplicationArea = All;
                }
                field(Comment; Comment)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Attachment Filepath"; PurchSetup."Purch Request Attachments Path")
                {
                    ApplicationArea = All;
                    Editable = false;
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
            }
        }
    }
    /*
    //Upload quote testing
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    TestCU: Codeunit "Purchase Requisition Mgmt";
                begin
                    TestCU.Run();
                end;
            }
        }
    }
    */
    var
        PurchSetup: Record "Purchases & Payables Setup";

    trigger OnOpenPage()
    begin
        PurchSetup.Get();
    end;

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