table 50052 "Purchase Requisition Quote"
{
    DataCaptionFields = "Quote No.", Description;
    fields
    {
        field(1; "Quote No."; Code[20])
        {
            trigger OnValidate();
            var
                PurchSetup: Record "Purchases & Payables Setup";
                NoSeriesMgmt: Codeunit NoSeriesManagement;
            begin
                IF "Quote No." <> xRec."Quote No." THEN BEGIN
                    PurchSetup.GET;
                    PurchSetup.TESTFIELD("Requisition Quote Nos.");
                    NoSeriesMgmt.TestManual(PurchSetup."Requisition Quote Nos.");
                    "No. Series" := '';
                END;
            end;
        }
        field(2; "Request No."; Code[20])
        {
            TableRelation = "Purchase Requisition Header";
        }
        field(3; "Request Line No."; Integer) { }
        field(4; Description; text[100]) { }
        field(5; Remarks; Text[250]) { }
        field(6; Quantity; Decimal)
        {
            trigger OnValidate()
            begin
                "Amount Excl VAT" := Quantity * "Unit Price";
            end;
        }
        field(7; "Unit Price"; Decimal)
        {
            trigger OnValidate()
            begin
                "Amount Excl VAT" := Quantity * "Unit Price";
            end;
        }
        field(8; "Amount Excl VAT"; Decimal) { }
        field(9; "Expected Delivery Date"; Date) { }
        field(10; "Vendor No."; Code[20])
        {
            trigger OnValidate()
            var
                Vendor: Record Vendor;
            begin
                if Vendor.Get("Vendor No.") then;
                "Vendor Name" := Vendor.Name;
                "Vendor Contact" := Vendor.Contact;
                "Vendor Phone No." := Vendor."Phone No.";
            end;
        }
        field(11; "Vendor Name"; text[100])
        {
            Editable = false;
        }
        field(12; "Vendor Contact"; text[100])
        {
            Editable = false;
        }
        field(13; "Vendor Phone No."; text[30])
        {
            Editable = false;
        }
        field(20; "Vendor Item Reference"; Text[50])
        {

        }
        field(21; "Vendor Quote No."; Code[20])
        {

        }
        field(25; Selected; Boolean)
        {
            trigger OnValidate()
            begin
                SelectedQuoteOnValidate();
            end;
        }
        field(26; "Date Selected"; Date) { }
        field(30; "No. Series"; Code[20])
        {

        }
        field(51; Attachment; Text[250])
        {
            DataClassification = CustomerContent;
            Editable = false;
            ExtendedDatatype = URL;
        }
        field(52; Comment; Text[250])
        {
            DataClassification = CustomerContent;
        }

        field(53; "Attachment Blob"; Blob)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Quote No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgmt: Codeunit NoSeriesManagement;
    begin
        IF "Quote No." = '' THEN BEGIN
            PurchSetup.GET;
            PurchSetup.TESTFIELD("Requisition Quote Nos.");
            NoSeriesMgmt.InitSeries(PurchSetup."Requisition Quote Nos.", xRec."No. Series", 0D, "Quote No.", "No. Series");
        END;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin
        Validate(Selected, false);
    end;

    trigger OnRename()
    begin

    end;

    procedure AssistEdit(OldReqQuote: Record "Purchase Requisition Quote"): Boolean;
    var
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgmt: Codeunit NoSeriesManagement;
    begin
        PurchSetup.GET;
        PurchSetup.TESTFIELD("Requisition Quote Nos.");
        IF NoSeriesMgmt.SelectSeries(PurchSetup."Requisition Quote Nos.", OldReqQuote."No. Series", "No. Series") THEN BEGIN
            NoSeriesMgmt.SetSeries("Quote No.");
            EXIT(TRUE);
        END;
    end;

    procedure SelectedQuoteOnValidate()
    var
        RequestLine: Record "Purchase Requisition Line";
        RequestHdr: Record "Purchase Requisition Header";
    begin
        RequestHdr.Get("Request No.");
        //RequestHdr.TestField(Status, RequestHdr.Status::Open);//Commented for demo - 24Sept2020
        RequestLine.Get("Request No.", "Request Line No.");
        if Selected then begin
            TestField(Quantity);
            TestField("Unit Price");
            TestField("Vendor No.");
            RequestLine."Selected Quote No." := "Quote No.";
            RequestLine.Validate(Quantity, Quantity);
            RequestLine.Validate("Unit Price", "Unit Price");
            RequestLine.Validate("Vendor No.", "Vendor No.");
            RequestLine.Modify(true);
        end else
            if "Quote No." = RequestLine."Selected Quote No." then begin
                RequestLine."Selected Quote No." := '';
                RequestLine.Validate(Quantity, 0);
                RequestLine.Validate("Unit Price", 0);
                RequestLine.Validate("Vendor No.", '');
                RequestLine.Modify(true);
            end;
    end;
}