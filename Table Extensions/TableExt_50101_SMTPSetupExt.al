tableextension 50101 SMTPSetupExt extends "SMTP Mail Setup"
{
    fields
    {
        field(50050; "Body (Request Mail to Approver)"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(50051; "Body (Request Mail to Sender)"; Text[250])
        {
            DataClassification = CustomerContent;
        }
    }
}