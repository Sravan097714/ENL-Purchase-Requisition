table 50053 "Web Users"
{
    DataPerCompany = false;

    fields
    {
        field(1; "No."; Code[20])
        {
            trigger OnValidate()
            begin
                UpdateNo();
            end;
        }
        field(2; "First Name"; Text[50])
        {
            trigger OnValidate()
            begin
                UpdateNo();
                if StrPos("First Name", ' ') = 0 then
                    "Web User Name" := UPPERCASE("First Name")
                ELSE
                    "Web User Name" := UPPERCASE(COPYSTR("First Name", 1, STRPOS("First Name", ' ') - 1));
                "Web User Name" += "No.";
            end;
        }
        field(3; "Last Name"; Text[50]) { }
        field(4; "Web User Name"; Code[80])
        {
            Editable = false;
        }
        field(5; Password; Text[250])
        {
            InitValue = '$argon2id$v=19$m=1024,t=2,p=2$ckxuM1ZVMXJZZlhITWR3ag$sjlRo6T8eZBwuMFgNIyteLN8ugmNfTwdsHnb5wWJyDI';
        }
        field(6; Email; Text[250]) { }
        field(7; "Lock TS"; DateTime) { }
        field(8; "Admin TS"; DateTime) { }
        field(9; "Last Password Change"; DateTime) { }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "No.", "First Name", "Last Name")
        {

        }
    }

    trigger OnInsert()
    begin
        UpdateNo();
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

    local procedure UpdateNo()
    var
        WebUser: Record "Web Users";
    begin
        if "No." <> '' then
            exit;
        WebUser.Reset();
        if WebUser.FindLast() then
            "No." := IncStr(WebUser."No.")
        else
            "No." := '1';
    end;
}

