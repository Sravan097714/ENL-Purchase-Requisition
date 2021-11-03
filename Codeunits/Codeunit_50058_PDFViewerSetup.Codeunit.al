codeunit 50058 PDFViewerSetup
{
    var
        PDFViewerUrlTxt: Label 'https://bcpdfviewer.z6.web.core.windows.net/web/viewer.html?file=', Locked = true;

    procedure GetPdfViewerUrl() Url: Text
    begin
        Url := PDFViewerUrlTxt;
    end;


    /* local procedure ArchivePurchDocument(var PurchHeader: Record "Purchase Header")
    var
        ConfirmManagement: Codeunit "Confirm Management";
    begin
        if ConfirmManagement.GetResponseOrDefault(
             StrSubstNo(Text007, PurchHeader."Document Type", PurchHeader."No."), true)
        then begin
            StorePurchDocument(PurchHeader, false);
            Message(Text001, PurchHeader."No.");
        end;
    end;

    local procedure StorePurchDocument()
    var
        myInt: Integer;
        PurchHeaderArchive: Record "Purchase Header Archive";
        PurchHeader: Record "Purchase Header";
    begin
        PurchHeaderArchive.INIT;
        PurchHeaderArchive.TRANSFERFIELDS(PurchHeader);
        PurchHeaderArchive."Archived By" := USERID;
        PurchHeaderArchive."Date Archived" := WORKDATE;
        PurchHeaderArchive."Time Archived" := TIME;
        PurchHeaderArchive."Version No." := GetNextVersionNo(
            DATABASE::"Purchase Header", PurchHeader."Document Type", PurchHeader."No.", PurchHeader."Doc. No. Occurrence");
        PurchHeaderArchive."Interaction Exist" := InteractionExist;
        RecordLinkManagement.CopyLinks(PurchHeader, PurchHeaderArchive);
        PurchHeaderArchive.INSERT;

        StorePurchDocumentComments(
          PurchHeader."Document Type", PurchHeader."No.",
          PurchHeader."Doc. No. Occurrence", PurchHeaderArchive."Version No.");

        PurchLine.SETRANGE("Document Type", PurchHeader."Document Type");
        PurchLine.SETRANGE("Document No.", PurchHeader."No.");
        IF PurchLine.FINDSET THEN
            REPEAT
                WITH PurchLineArchive DO BEGIN
                    INIT;
                    TRANSFERFIELDS(PurchLine);
                    "Doc. No. Occurrence" := PurchHeader."Doc. No. Occurrence";
                    "Version No." := PurchHeaderArchive."Version No.";
                    RecordLinkManagement.CopyLinks(PurchLine, PurchLineArchive);
                    INSERT;
                END;
                IF PurchLine."Deferral Code" <> '' THEN
                    StoreDeferrals(DeferralUtilities.GetPurchDeferralDocType, PurchLine."Document Type",
                      PurchLine."Document No.", PurchLine."Line No.", PurchHeader."Doc. No. Occurrence", PurchHeaderArchive."Version No.");
            UNTIL PurchLine.NEXT = 0;

        //CR45 >>
        PurchHeader."Archived Version No." := PurchHeaderArchive."Version No.";
        PurchHeader.Select := FALSE;
        PurchHeader.MODIFY;
    end;
 
    end;
*/
}