tableextension 50117 PurchaseHeaderArchiveExt extends "Purchase Header Archive"
{
    fields
    {
        field(60005; Archive; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Archive';
        }/*
        field(60000; "Request No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        /* field(600012; "Restored"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60010; "Archive Version No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(60011; "Last Restored Archive Version"; Integer)
        {
            DataClassification = ToBeClassified;
        } */
    }



    var
        myInt: Integer;
}