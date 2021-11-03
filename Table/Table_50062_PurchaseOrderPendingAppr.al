table 50062 "PurchaseOrderPendingAppr"
{
    Caption = 'Purchase Order Pending Approval';


    fields
    {
        field(50000; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        /*field(50001; "User ID Filter"; Code[50])
        {
            Caption = 'User ID Filter';
            FieldClass = FlowFilter;
        }*/
        field(50002; "PurchaseOrderPending"; Integer)
        {

            AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = CONST(Order),
                                                         Status = FILTER("Pending Approval")));
            Caption = 'POs Pending Approval';
            FieldClass = FlowField;

        }
        field(50003; "PurchaseInvPending"; Integer)
        {
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = const(Invoice),
                                                        Status = filter("Pending Approval")));
            Caption = 'PI Pending Approval';
            FieldClass = FlowField;
        }
        field(50004; "Purchase Request Ready For PO"; Integer)
        {
            CalcFormula = Count("Purchase Requisition Line" WHERE("Ready for PO" = const(true),
                                                                  "Purchase Doc Created" = const(false),
                                                                 "Transaction Type" = const(Order),
                                                                   Cancelled = const(false)));
            Caption = 'PR Ready for PO';
            FieldClass = FlowField;
        }
        field(50005; "Purchase Request Ready For PI"; Integer)
        {
            CalcFormula = Count("Purchase Requisition Line" WHERE("Ready for PO" = filter(true),
                                                                "Purchase Doc Created" = filter(false),
                                                                "Transaction Type" = filter(Invoice),
                                                                Cancelled = filter(false)));
            Caption = 'PR Ready for PI';
            FieldClass = FlowField;
        }
        field(50006; "Purchase Request Cancelled"; Integer)
        {
            CalcFormula = Count("Purchase Requisition Line" WHERE("Ready for PO" = const(true),
                                                                    "Purchase Doc Created" = const(false),
                                                                    Cancelled = const(true)));
            Caption = 'PR cancelled';
            FieldClass = FlowField;
        }

    }
    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    local procedure GetAmountFormat(): Text
    var
        ActivitiesCue: Record "Activities Cue";
    begin
        exit(ActivitiesCue.GetAmountFormat);
    end;
}