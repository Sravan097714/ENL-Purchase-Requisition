table 50063 "VendorPayment"
{
    Caption = 'Vendor Approval';

    DrillDownPageID = "Job Queue Entries";
    LookupPageID = "Job Queue Entries";
    ReplicateData = false;

    fields
    {
        field(50000; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(50001; "User ID Filter"; Code[50])
        {
            Caption = 'User ID Filter';
            FieldClass = FlowFilter;
        }
        field(50002; "Approved"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Sender ID" = FIELD("User ID Filter"),
                                                        Status = filter(Approved),
                                                        "Approval Code" = filter('MS-GJLAPW**')));
            Caption = 'Approved';
            FieldClass = FlowField;
        }
        field(50003; "Canceled"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Sender ID" = FIELD("User ID Filter"),
                                                        Status = filter(Canceled),
                                                        "Approval Code" = filter('MS-GJLAPW**')));
            Caption = 'Canceled';
            FieldClass = FlowField;
        }
        field(50004; "Created"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Sender ID" = FIELD("User ID Filter"),
                                                        Status = filter(Created),
                                                        "Approval Code" = filter('MS-GJLAPW**')));
            Caption = 'Created';
            FieldClass = FlowField;
        }
        field(50005; "Open"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Sender ID" = FIELD("User ID Filter"),
                                                        Status = filter(Open),
                                                        "Approval Code" = filter('MS-GJLAPW**')));
            Caption = 'Open';
            FieldClass = FlowField;
        }
        field(50006; "Rejected"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Sender ID" = FIELD("User ID Filter"),
                                                        Status = filter(Rejected),
                                                        "Approval Code" = filter('MS-GJLAPW**')));
            Caption = 'Rejected';
            FieldClass = FlowField;
        }
        field(50007; "All Approved Payments"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Approval Code" = filter('MS-GJLAPW**'), Status = filter(Approved)));
            Caption = 'All Approved Payments';
            FieldClass = FlowField;
        }
        field(50008; "All Pending Payments"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Approval Code" = filter('MS-GJLAPW**'), Status = filter(Open)));
            Caption = 'All Pending Payments';
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
}