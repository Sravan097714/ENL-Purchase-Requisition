pageextension 50122 SMTPSetupExt extends "SMTP Mail Setup"
{
    layout
    {
        addafter(General)
        {
            group("Purchase Request Mail Templates")
            {
                field("Body (Request Mail to Approver)"; "Body (Request Mail to Approver)")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Body (Request Mail to Sender)"; "Body (Request Mail to Sender)")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
        }
    }
}