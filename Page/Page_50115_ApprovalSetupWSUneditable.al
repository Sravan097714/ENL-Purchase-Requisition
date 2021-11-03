page 50115 "ApprovalSetupWSUneditable"
{
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Web Approval Setup";
    DelayedInsert = true;
    Caption = 'Requisition Approval User Setup';
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        UpdateControls();
                    end;
                }
                field(DeptName; DeptName)
                {
                    ApplicationArea = All;
                    Caption = 'Department Name';
                    Editable = false;
                }
                field("Purchase Type"; "Purchase Type")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        UpdateControls();
                    end;
                }
                field(PurchTypeDesc; PurchTypeDesc)
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Type Description';
                    Editable = false;
                }
                field(Initiator; Initiator)
                {
                    ApplicationArea = All;
                }
                field(InitiatorName; InitiatorName)
                {
                    ApplicationArea = All;
                    Caption = 'Initiator Name';
                    Editable = false;
                }
                field("Initiator Delegator"; "Initiator Delegator")
                {
                    ApplicationArea = All;
                }
                field(InitiatorDelegatorName; InitiatorDelegatorName)
                {
                    ApplicationArea = All;
                    Caption = 'Initiator Delegator Name';
                    Editable = false;
                }
                field("Level 1 Approval <"; "Level 1 Approval <")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        UpdateControls();
                    end;
                }
                field(Level1Appr1; Level1Appr1)
                {
                    ApplicationArea = All;
                    Caption = 'Name';
                    Editable = false;
                }
                field("Level 1 Deligation <"; "Level 1 Deligation <")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        UpdateControls();
                    end;
                }
                field(Level1Deligation1; Level1Deligation1)
                {
                    ApplicationArea = All;
                    Caption = 'Name';
                    Editable = false;
                }
                field("Level 1 Approval >"; "Level 1 Approval >")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        UpdateControls();
                    end;
                }
                field(Level1Appr2; Level1Appr2)
                {
                    ApplicationArea = All;
                    Caption = 'Name';
                    Editable = false;
                }
                field("Level 1 Deligation >"; "Level 1 Deligation >")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        UpdateControls();
                    end;
                }
                field(Level1Deligation2; Level1Deligation2)
                {
                    ApplicationArea = All;
                    Caption = 'Name';
                    Editable = false;
                }
                field("Level 2 Approval"; "Level 2 Approval")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        UpdateControls();
                    end;
                }
                field(Level2Appr; Level2Appr)
                {
                    ApplicationArea = All;
                    Caption = 'Name';
                    Editable = false;
                }
                field("Level 2 Deligation"; "Level 2 Deligation")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        UpdateControls();
                    end;
                }
                field(Level2Deligation; Level2Deligation)
                {
                    ApplicationArea = All;
                    Caption = 'Name';
                    Editable = false;
                }
            }
        }
    }
    var
        DeptName: Text[50];
        PurchTypeDesc: Text[50];
        InitiatorName: Text[100];
        InitiatorDelegatorName: Text[100];
        Level1Appr1: Text[100];
        Level1Deligation1: Text[100];
        Level1Appr2: Text[100];
        Level1Deligation2: Text[100];
        Level2Appr: Text[100];
        Level2Deligation: Text[100];

    trigger OnAfterGetRecord()
    begin
        UpdateControls();
    end;

    local procedure UpdateControls()
    var
        GLSetup: Record "General Ledger Setup";
        DimVal: Record "Dimension Value";
        PurchTypes: Record "Purchase Types";

    begin
        GLSetup.get();
        DimVal.Reset();
        DimVal.SetRange("Dimension Code", GLSetup."Shortcut Dimension 1 Code");
        DimVal.SetRange(Code, "Shortcut Dimension 1 Code");
        if DimVal.FindFirst() then;
        DeptName := DimVal.Name;

        if PurchTypes.Get("Purchase Type") then;
        PurchTypeDesc := PurchTypes.Description;

        InitiatorName := GetUserName(Initiator);
        InitiatorDelegatorName := GetUserName("Initiator Delegator");
        Level1Appr1 := GetUserName("Level 1 Approval <");
        Level1Deligation1 := GetUserName("Level 1 Deligation <");
        Level1Appr2 := GetUserName("Level 1 Approval >");
        Level1Deligation2 := GetUserName("Level 1 Deligation >");
        Level2Appr := GetUserName("Level 2 Approval");
        Level2Deligation := GetUserName("Level 2 Deligation");
    end;

    local procedure GetUserName(WebUserId: Code[20]): Text[100]
    var
        WebUser: Record "Web Users";
    begin
        if WebUser.Get(WebUserId) then
            exit(WebUser."First Name" + ' ' + WebUser."Last Name");
        exit('');
    end;
}