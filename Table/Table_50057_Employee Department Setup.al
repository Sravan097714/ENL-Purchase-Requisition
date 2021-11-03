table 50057 "Employee Department Setup"
{
    DataClassification = CustomerContent;
    LookupPageId = "Employee Department Setup";
    DrillDownPageId = "Employee Department Setup";
    fields
    {
        field(1; "Employee No."; Code[20])
        {
            TableRelation = "Web Users"."No.";
            NotBlank = true;
            trigger OnValidate()
            var
                WebUser: Record "Web Users";
            begin
                if WebUser.Get("Employee No.") then;
                "Employee Name" := WebUser."First Name";
            end;
        }
        field(2; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            NotBlank = true;
            trigger OnValidate()
            var
                GLSetup: Record "General Ledger Setup";
                DimVal: Record "Dimension Value";
            begin
                GLSetup.get();
                DimVal.Reset();
                DimVal.SetRange("Dimension Code", GLSetup."Shortcut Dimension 1 Code");
                DimVal.SetRange(Code, "Shortcut Dimension 1 Code");
                if DimVal.FindFirst() then;
                "Department Name" := DimVal.Name;
            end;
        }
        field(8; "Employee Name"; Text[50])
        {
            Editable = false;
        }
        field(9; "Department Name"; Text[50])
        {
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Employee No.", "Shortcut Dimension 1 Code")
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