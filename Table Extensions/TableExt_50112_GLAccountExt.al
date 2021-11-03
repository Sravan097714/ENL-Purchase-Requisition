tableextension 50112 GLAccountExt extends "G/L Account"
{
    fields
    {
        field(50050; "Purchase Type"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Purchase Types".Code;
        }
    }
}