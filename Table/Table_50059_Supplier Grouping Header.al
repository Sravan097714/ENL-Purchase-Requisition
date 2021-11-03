table 50059 "Supplier Grouping Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Request No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Vendor No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Supplier No.';
        }
        field(5; "Vendor Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Supplier Name';
        }
        field(8; "Total Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(10; Status; Enum "Request Line Status")
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Request No.", "Vendor No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;
}