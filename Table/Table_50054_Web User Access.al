table 50054 "Web User Access"
{
    DataPerCompany = false;

    fields
    {
        field(1; "Web User No."; Code[20])
        {
            TableRelation = "Web Users"."No.";
        }
        field(2; "Company Name"; Text[30])
        {
            TableRelation = Company.Name;
        }
    }

    keys
    {
        key(PK; "Web User No.", "Company Name")
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
