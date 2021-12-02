tableextension 50118 PurchInvHdrExt extends "Purch. Inv. Header"
{
    fields
    {
        field(50050; "Released Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(60000; "Request No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
    }

    var
        myInt: Integer;
}