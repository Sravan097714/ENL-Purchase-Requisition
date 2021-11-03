table 50055 "Web Approval Setup"
{
    fields
    {
        field(1; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            NotBlank = true;
        }
        field(2; "Purchase Type"; code[20])
        {
            TableRelation = "Purchase Types".Code;
            NotBlank = true;
        }
        field(10; Initiator; code[20])
        {
            TableRelation = "Purchase Category Initiator".Initiator where(Category = field("Purchase Type"));
        }
        field(11; "Initiator Delegator"; code[20])
        {
            TableRelation = "Purchase Category Initiator".Initiator where (Category = field ("Purchase Type"));
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                TestField(Initiator);
                if "Initiator Delegator" <> '' then
                    if Initiator = "Initiator Delegator" then
                        Error('Both %1 and %2 should not be same', FieldCaption(Initiator), FieldCaption("Initiator Delegator"));
            end;
        }
        field(20; "Level 1 Approval <"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = GetCaptionClass(FieldNo("Level 1 Approval <"));
            TableRelation = "Web Users"."No.";
        }
        field(21; "Level 1 Deligation <"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = GetCaptionClass(FieldNo("Level 1 Deligation <"));
            TableRelation = "Web Users"."No.";
        }
        field(22; "Level 1 Approval >"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = GetCaptionClass(FieldNo("Level 1 Approval >"));
            TableRelation = "Web Users"."No.";
        }
        field(23; "Level 1 Deligation >"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = GetCaptionClass(FieldNo("Level 1 Deligation >"));
            TableRelation = "Web Users"."No.";
        }
        field(24; "Level 2 Approval"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Web Users"."No.";
        }
        field(25; "Level 2 Deligation"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Web Users"."No.";
        }
    }

    keys
    {
        key(PK; "Shortcut Dimension 1 Code", "Purchase Type")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        TestField("Shortcut Dimension 1 Code");
        TestField("Purchase Type");
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

    LOCAL procedure GetCaptionClass(FieldNumber: Integer): Text[80]
    var
        PurchSetup: Record "Purchases & Payables Setup";
    begin
        PurchSetup.Get();
        EXIT(GetFieldCaption(FieldNumber) + Format(PurchSetup."Threshold Amount"));
    end;

    LOCAL procedure GetFieldCaption(FieldNumber: Integer): Text[100]
    var
        Field: Record Field;
    begin
        Field.GET(DATABASE::"Web Approval Setup", FieldNumber);
        EXIT(Field."Field Caption");
    end;
}