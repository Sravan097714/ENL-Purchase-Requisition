table 50058 "Purchase Category Initiator"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Category; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Purchase Types".Code;
        }
        field(2; Initiator; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Web Users"."No.";
            trigger OnValidate()
            var
                WebUser: Record "Web Users";
            begin
                if WebUser.Get(Initiator) then;
                "Initiator Name" := WebUser."First Name";
            end;
        }
        field(5; "Initiator Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(10; "Purchase Order Nos."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(11; "Purchase Invoice Nos."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(PK; Category, Initiator)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; Category, Initiator, "Initiator Name")
        {

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