codeunit 50020 "Purchase Requisition Mgmt"
{
    trigger OnRun()
    var
        ReturnBigTxt: BigText;
        FileName: Text;
    begin
        /*
        GetBigText(ReturnBigTxt, FileName);
        FileName := DelChr(FileName, '=', '.');
        Message(FileName);
        UploadQuote('P-QUO00185', ReturnBigTxt, FileName, 'txt');
        */
    end;
    /*
    local procedure GetBigText(VAR ReturnBigTxt: BigText; VAR FileName: Text)
    var
        FileMgt: Codeunit "File Management";
        Tempblob: Codeunit "Temp Blob";
        IStream: InStream;
        MemoryStream: DotNet MemoryStream;
        Bytes: DotNet Bytes;
        Convert: DotNet Convert;
    begin
        FileName := FileMgt.BLOBImport(TempBlob, '');
        TempBlob.CREATEINSTREAM(IStream);
        MemoryStream := MemoryStream.MemoryStream();
        COPYSTREAM(MemoryStream, IStream);
        Bytes := MemoryStream.ToArray();

        //Return parameters
        ReturnBigTxt.ADDTEXT(Convert.ToBase64String(Bytes));
    end;
    */
    procedure GetQuoteContent(QuoteNo: Code[20]; VAR FileContent: BigText; VAR FileName: Text[250]; VAR FileExtension: Text[10])
    var
        FileMgt: Codeunit "File Management";
        RequestQuote: Record "Purchase Requisition Quote";
        Tempblob: Record TempBlob;
        IStream: InStream;
        MemoryStream: DotNet MemoryStream;
        Bytes: DotNet Bytes;
        Convert: DotNet Convert;
    begin
        RequestQuote.get(QuoteNo);
        if RequestQuote.Attachment = '' then
            exit;
        if not Exists(RequestQuote.Attachment) then
            exit;
        TempBlob.Blob.Import(RequestQuote.Attachment);
        TempBlob.Blob.CreateInStream(IStream);
        MemoryStream := MemoryStream.MemoryStream();
        COPYSTREAM(MemoryStream, IStream);
        Bytes := MemoryStream.ToArray();

        //Return parameters
        FileContent.ADDTEXT(Convert.ToBase64String(Bytes));
        FileName := FileMgt.GetFileName(RequestQuote.Attachment);
        FileName := FileMgt.GetFileNameWithoutExtension(FileName);
        FileExtension := FileMgt.GetExtension(FileName);
    end;

    procedure UploadQuote(QuoteNo: Code[20]; FileContent: BigText; FileName: Text[250]; FileExtension: Text[10])
    var
        RequestQuote: Record "Purchase Requisition Quote";
        PurchSetup: Record "Purchases & Payables Setup";
        TempBlob: Record TempBlob;
        Convert: DotNet Convert;
        Bytes: DotNet Bytes;
        MemoryStream: DotNet MemoryStream;
        OutStr: OutStream;
        InStr: InStream;
        Filepath: Text;
    begin
        RequestQuote.get(QuoteNo);
        PurchSetup.Get();
        PurchSetup.TestField("Purch Request Attachments Path");

        Filepath := PurchSetup."Purch Request Attachments Path";
        if CopyStr(Filepath, StrLen(Filepath), 1) <> '\' then
            Filepath += '\';
        FileName += '_' + RemoveSplChars(RequestQuote."Quote No.");
        Filepath += FileName + '.' + FileExtension;
        if Exists(Filepath) then
            Erase(Filepath);

        Bytes := Convert.FromBase64String(FileContent);
        MemoryStream := MemoryStream.MemoryStream(Bytes);
        RequestQuote."Attachment Blob".CreateOutStream(OutStr);
        MemoryStream.WriteTo(OutStr);
        RequestQuote.Modify();
        RequestQuote.calcfields("Attachment Blob");
        RequestQuote."Attachment Blob".Export(Filepath);
        clear(RequestQuote."Attachment Blob");

        if RequestQuote.Attachment <> '' then
            if Exists(RequestQuote.Attachment) then
                Erase(RequestQuote.Attachment);

        RequestQuote.Attachment := Filepath;
        RequestQuote.Modify();
    end;

    procedure RemoveQuote(QuoteNo: Code[20])
    var
        RequestQuote: Record "Purchase Requisition Quote";
    begin
        RequestQuote.get(QuoteNo);
        if RequestQuote.Attachment = '' then
            exit;
        if Exists(RequestQuote.Attachment) then
            Erase(RequestQuote.Attachment);
        RequestQuote.Attachment := '';
        RequestQuote.Modify(true);
    end;

    procedure DeleteRequestLine(RequestNo: Code[20]; RequestLineNo: Integer)
    var
        PurchReqLine: Record "Purchase Requisition Line";
        RequestQuote: Record "Purchase Requisition Quote";
        RequestQuote2: Record "Purchase Requisition Quote";
    begin
        RequestQuote.SetRange("Request No.", RequestNo);
        RequestQuote.SetRange("Request Line No.", RequestLineNo);
        if RequestQuote.FindSet() then
            repeat
                RemoveQuote(RequestQuote."Quote No.");
                RequestQuote2.Get(RequestQuote."Quote No.");
                RequestQuote2.Delete(true);
            until RequestQuote.Next() = 0;

        PurchReqLine.get(RequestNo, RequestLineNo);
        PurchReqLine.Delete(true);
    end;

    local procedure RemoveSplChars(InputTxt: Text) ReturnTxt: text;
    begin
        ReturnTxt := DelChr(InputTxt, '=', '/\,.<>!@#$%^&*()')
    end;

    procedure UpdateRequestHeaderStatus(RequestNo: Code[20])
    var
        RequestHdr: Record "Purchase Requisition Header";
        SupplierGrouping: Record "Supplier Grouping Header";
        PendingEntriesFound: Boolean;
        RejectedEntriesFound: Boolean;
        ApprovedEntriesFound: Boolean;
    begin
        RequestHdr.Get(RequestNo);
        SupplierGrouping.SetRange("Request No.", RequestHdr."Request No.");
        if SupplierGrouping.FindSet() then
            repeat
                Case SupplierGrouping.Status of
                    SupplierGrouping.Status::"Pending Approval":
                        PendingEntriesFound := true;
                    SupplierGrouping.Status::Rejected:
                        RejectedEntriesFound := true;
                    SupplierGrouping.Status::Approved:
                        ApprovedEntriesFound := true;
                end;
            until (SupplierGrouping.Next() = 0) or PendingEntriesFound;

        case true of
            PendingEntriesFound://At least 1 Pending Approval
                RequestHdr.validate(Status, RequestHdr.Status::"Pending Approval");
            RejectedEntriesFound and ApprovedEntriesFound and (not PendingEntriesFound)://Approved + Rejected
                RequestHdr.validate(Status, RequestHdr.Status::"Partly Approved");
            (not RejectedEntriesFound) and ApprovedEntriesFound and (not PendingEntriesFound)://All Approved
                RequestHdr.validate(Status, RequestHdr.Status::Approved);
            RejectedEntriesFound and (not ApprovedEntriesFound) and (not PendingEntriesFound)://All Rejected
                RequestHdr.validate(Status, RequestHdr.Status::Rejected);
        end;
        RequestHdr.Modify(true);
    end;

    procedure CopyRequest(RequestNo: Code[20]; var ToRequestNo: Code[20])
    var
        FromRequestHdr: Record "Purchase Requisition Header";
        FromRequestLine: Record "Purchase Requisition Line";
        FromRequestQuote: Record "Purchase Requisition Quote";
        ToRequestHdr: Record "Purchase Requisition Header";
        ToRequestLine: Record "Purchase Requisition Line";
        ToRequestQuote: Record "Purchase Requisition Quote";
        SupplierGroupingHdr: Record "Supplier Grouping Header";
    begin
        FromRequestHdr.Get(RequestNo);
        if not (FromRequestHdr.Status in
            [FromRequestHdr.status::"Partly Approved", FromRequestHdr.status::Rejected])
        then
            Error('You cannot make a copy if status is %1 for request %2, it should be either %3 or %4',
                FromRequestHdr.Status, RequestNo, FromRequestHdr.Status::"Partly Approved", FromRequestHdr.Status::Rejected);

        ToRequestHdr.Init();
        ToRequestHdr."Request No." := '';
        ToRequestHdr.Insert(true);
        ToRequestHdr.validate("Employee No.", FromRequestHdr."Employee No.");
        ToRequestHdr.Validate("Shortcut Dimension 1 Code", FromRequestHdr."Shortcut Dimension 1 Code");
        ToRequestHdr.Validate("Purchase Type", FromRequestHdr."Purchase Type");
        ToRequestHdr."Date of Request" := Today;
        ToRequestHdr.Status := ToRequestHdr.Status::open;
        ToRequestHdr.RequestedBy := FromRequestHdr.RequestedBy;
        ToRequestHdr."Transaction Type" := FromRequestHdr."Transaction Type";
        ToRequestHdr.Modify(true);

        SupplierGroupingHdr.SetRange("Request No.", FromRequestHdr."Request No.");
        SupplierGroupingHdr.SetRange(Status, SupplierGroupingHdr.Status::Rejected);
        SupplierGroupingHdr.FindSet();
        repeat
            FromRequestLine.Reset();
            FromRequestLine.SetRange("Request No.", SupplierGroupingHdr."Request No.");
            FromRequestLine.SetRange("Vendor No.", SupplierGroupingHdr."Vendor No.");
            FromRequestLine.FindSet();
            repeat
                ToRequestLine.Init();
                ToRequestLine."Request No." := ToRequestHdr."Request No.";
                ToRequestLine."Line No." := FromRequestLine."Line No.";
                ToRequestLine.Insert(true);
                ToRequestLine.UpdateHeaderData();
                ToRequestLine.Validate("G/L Account No.", FromRequestLine."G/L Account No.");
                ToRequestLine.Modify(true);

                FromRequestQuote.Reset();
                FromRequestQuote.SetRange("Request No.", FromRequestLine."Request No.");
                FromRequestQuote.SetRange("Request Line No.", FromRequestLine."Line No.");
                if FromRequestQuote.FindSet() then
                    repeat
                        ToRequestQuote.Reset();
                        ToRequestQuote.Init();
                        ToRequestQuote.TransferFields(FromRequestQuote);
                        ToRequestQuote."Quote No." := '';
                        ToRequestQuote."Request No." := ToRequestLine."Request No.";
                        ToRequestQuote."Request Line No." := ToRequestLine."Line No.";
                        ToRequestQuote."Expected Delivery Date" := 0D;
                        ToRequestQuote.Selected := false;
                        ToRequestQuote.Attachment := '';
                        ToRequestQuote.insert(true);
                        CopyAttachment(FromRequestQuote, ToRequestQuote);
                    until FromRequestQuote.Next() = 0;
            until FromRequestLine.Next() = 0;
        until SupplierGroupingHdr.Next() = 0;
        ToRequestNo := ToRequestHdr."Request No.";
        FromRequestHdr.validate(Status, FromRequestHdr.Status::Completed);
        FromRequestHdr."Copy Date" := CurrentDateTime;
        FromRequestHdr.Modify();
    end;

    local procedure CopyAttachment(FromQuote: Record "Purchase Requisition Quote"; ToQuote: Record "Purchase Requisition Quote")
    var
        PurchSetup: Record "Purchases & Payables Setup";
        Filepath: Text;
        FileName: Text;
        FileExtension: Text[10];
    begin
        if FromQuote.Attachment = '' then
            exit;
        if not Exists(FromQuote.Attachment) then
            exit;
        ToQuote."Attachment Blob".Import(FromQuote.Attachment);
        ToQuote.Modify();

        PurchSetup.Get();
        PurchSetup.TestField("Purch Request Attachments Path");

        Filepath := PurchSetup."Purch Request Attachments Path";
        if CopyStr(Filepath, StrLen(Filepath), 1) <> '\' then
            Filepath += '\';
        FileName += '_' + RemoveSplChars(ToQuote."Quote No.");
        Filepath += FileName + '.' + FileExtension;
        if Exists(Filepath) then
            Erase(Filepath);

        ToQuote.CalcFields("Attachment Blob");
        ToQuote."Attachment Blob".Export(Filepath);
        Clear(ToQuote."Attachment Blob");
        ToQuote.Attachment := Filepath;
        ToQuote.Modify();
    end;

    procedure UpdateRequestLineFromQuote(QuoteNo: Code[20])
    var
        RequestQuote: Record "Purchase Requisition Quote";
    begin
        RequestQuote.Get(QuoteNo);
        RequestQuote.SelectedQuoteOnValidate();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnCodeOnBeforeModifyHeader', '', true, true)]
    local procedure "Release Purchase Document_OnCodeOnBeforeModifyHeader"
    (
        var PurchaseHeader: Record "Purchase Header";
        var PurchaseLine: Record "Purchase Line";
        PreviewMode: Boolean;
        var LinesWereModified: Boolean
    )
    var
        UserLRec: Record User;
    begin
        PurchaseHeader."Released Date" := WorkDate();
        UserLRec.Get(UserSecurityId());
        PurchaseHeader."Approver Name" := UserLRec."Full Name";
    end;

}