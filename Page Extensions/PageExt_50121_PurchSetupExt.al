pageextension 50121 PurchSetupExt extends "Purchases & Payables Setup"
{
    layout
    {
        addlast("Number Series")
        {
            field("Purchase Requisition Nos."; "Purchase Requisition Nos.")
            {
                ApplicationArea = All;
            }
            field("Requisition Quote Nos."; "Requisition Quote Nos.")
            {
                ApplicationArea = All;
            }
        }
        addlast(General)
        {
            field("Purch Request Attachments Path"; "Purch Request Attachments Path")
            {
                ApplicationArea = All;
            }
            field("Threshold Amount"; "Threshold Amount")
            {
                ApplicationArea = All;
            }
        }
    }
}