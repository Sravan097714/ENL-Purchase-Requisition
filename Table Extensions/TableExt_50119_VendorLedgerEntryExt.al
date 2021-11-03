tableextension 50119 VendorLedgerEntryExt extends 25
{
    fields
    {
        field(60010; "Request No."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Purch. Inv. Header"."Request No." where("No." = field("Document No."), "Vendor Invoice No." = field("External Document No.")));
        }
    }

    var
        myInt: Integer;
}