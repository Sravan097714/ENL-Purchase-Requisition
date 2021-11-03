tableextension 50111 PurchaseLineExt extends "Purchase Line"
{
    fields
    {
        field(60000; "Request No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(60001; "Request Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(60002; Attachment; Text[250])
        {
            DataClassification = CustomerContent;
            Editable = false;
            ExtendedDatatype = URL;
        }
        field(60003; "Document Link"; Text[250])
        {
            DataClassification = CustomerContent;
            Editable = false;
            ExtendedDatatype = URL;
        }

    }
}