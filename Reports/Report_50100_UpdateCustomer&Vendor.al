report 50100 "Üpdate Customer & veendor"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;
    Permissions = Tabledata "Sales Invoice Header" = m,
                Tabledata "Sales Cr.Memo Header" = m, Tabledata "Sales Shipment Header" = m,
                Tabledata "Purch. Inv. Header" = m, Tabledata "Purch. Rcpt. Header" = m,
                Tabledata "Purch. Cr. Memo Hdr." = m;

    dataset
    {
        dataitem(Customer; Customer)
        {

            trigger OnAfterGetRecord()
            var
                SalesInvHead: Record "Sales Invoice Header";
                SalesShipHead: Record "Sales Shipment Header";
                SalesCredmemoHead: Record "Sales Cr.Memo Header";
                SalesHead: Record "Sales Header";
            begin
                SalesInvHead.Reset();
                SalesInvHead.SetRange("Sell-to Customer No.", Customer."No.");
                if SalesInvHead.FindSet() then
                    SalesInvHead.ModifyAll("Sell-to Customer Name", Customer.Name);
                SalesShipHead.Reset();
                SalesShipHead.SetRange("Sell-to Customer No.", Customer."No.");
                if SalesShipHead.FindSet() then
                    SalesShipHead.ModifyAll("Sell-to Customer Name", Customer.Name);
                SalesCredmemoHead.Reset();
                SalesCredmemoHead.SetRange("Sell-to Customer No.", Customer."No.");
                if SalesCredmemoHead.FindSet() then
                    SalesCredmemoHead.ModifyAll("Sell-to Customer Name", Customer.Name);
                SalesHead.Reset();
                SalesHead.SetRange("Sell-to Customer No.", Customer."No.");
                if SalesHead.FindSet() then
                    SalesHead.ModifyAll("Sell-to Customer Name", Customer.Name);
                Customer."Bill-to Customer No." := '';
                Customer.Modify();

            end;
        }
        dataitem(Vendor; Vendor)
        {


            trigger OnAfterGetRecord()
            var
                PurchInvHead: Record "Purch. Inv. Header";
                PurchRctHead: Record "Purch. Rcpt. Header";
                PurchCredmemoHead: Record "Purch. Cr. Memo Hdr.";
                PurchHead: Record "Purchase Header";
            begin
                "Pay-to Vendor No." := '';
                Vendor.Modify();
                PurchInvHead.Reset();
                PurchInvHead.SetRange("Buy-from Vendor No.", Vendor."No.");
                if PurchInvHead.FindSet() then
                    PurchInvHead.ModifyAll("Buy-from Vendor Name", Vendor.Name);
                PurchRctHead.Reset();
                PurchRctHead.SetRange("Buy-from Vendor No.", Vendor."No.");
                if PurchRctHead.FindSet() then
                    PurchRctHead.ModifyAll("Buy-from Vendor Name", Vendor.Name);

                PurchCredmemoHead.Reset();
                PurchCredmemoHead.SetRange("Buy-from Vendor No.", Vendor."No.");
                if PurchCredmemoHead.FindSet() then
                    PurchCredmemoHead.ModifyAll("Buy-from Vendor Name", Vendor.Name);

                PurchHead.Reset();
                PurchHead.SetRange("Buy-from Vendor No.", Vendor."No.");
                if PurchHead.FindSet() then
                    PurchHead.ModifyAll("Buy-from Vendor Name", Vendor.Name);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {

            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    var
        myInt: Integer;
}