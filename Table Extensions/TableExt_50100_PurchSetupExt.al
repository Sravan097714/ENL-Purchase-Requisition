tableextension 50100 PurchSetupExt extends "Purchases & Payables Setup"
{
    fields
    {
        field(50050; "Purchase Requisition Nos."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50051; "Requisition Quote Nos."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50052; "Purch Request Attachments Path"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Purchase Request Attachments Path';
        }
        field(50053; "Threshold Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            BlankZero = true;
        }
    }
}