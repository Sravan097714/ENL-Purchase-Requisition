table 50060 "Request Approval Entry"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Request No."; Code[20])
        {
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(2; "Vendor No."; Code[20])
        {
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(3; "Approval Level"; Integer)
        {
            DataClassification = CustomerContent;
            MinValue = 1;
            InitValue = 1;
        }
        field(10; "Approver No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(11; "Approver Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(12; "Deligate No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(13; "Deligate Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(14; "Use Deligate"; Boolean)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if "Use Deligate" then
                    TestField("Deligate No.");
            end;
        }
        field(15; Comment; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(16; Decision; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(17; "Decision Timestamp"; Date)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                DecisionTimestampOnValidate();
                UpdateSupplierGroupingStatus();
            end;
        }
    }

    keys
    {
        key(PK; "Request No.", "Vendor No.", "Approval Level")
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

    local procedure DecisionTimestampOnValidate()
    var
        ReqHdr: Record "Purchase Requisition Header";
        ReqApprEntry: Record "Request Approval Entry";
    begin
        if "Decision Timestamp" = 0D then
            exit;
        if "Approval Level" > 1 then
            ValidateApprovalEntry();//To check whether all previous entries are approved or not

        ReqHdr.Get("Request No.");
        if Decision then begin
            if ReqApprEntry.Get("Request No.", "Vendor No.", "Approval Level" + 1) then begin
                //>>To next approver
                if ReqApprEntry."Use Deligate" then
                    ReqHdr.MailNotify(ReqApprEntry, ReqApprEntry."Deligate No.", 'Send')
                else
                    ReqHdr.MailNotify(ReqApprEntry, ReqApprEntry."Approver No.", 'Send');
                //<<To next approver
            end else
                ReqHdr.MailNotify(Rec, ReqHdr."Employee No.", 'Approved');//To Initiator if final approver approves
        end else
            ReqHdr.MailNotify(Rec, ReqHdr."Employee No.", 'Rejected');// To Initiator, if rejects at any level
    end;

    local procedure ValidateApprovalEntry()
    var
        PrevApprEntries: Record "Request Approval Entry";
    begin
        PrevApprEntries.SetRange("Request No.", "Request No.");
        PrevApprEntries.SetRange("Vendor No.", "Vendor No.");
        PrevApprEntries.SetFilter("Approval Level", '<%1', "Approval Level");
        PrevApprEntries.SetRange(Decision, false);
        if not PrevApprEntries.IsEmpty then
            Error('Approval Entry is not valid. Previous Approvals are not approved yet.');
    end;

    local procedure UpdateSupplierGroupingStatus()
    var
        SupplierGrouping: Record "Supplier Grouping Header";
        PurchSetup: Record "Purchases & Payables Setup";
    begin
        if "Decision Timestamp" = 0D then
            exit;
        PurchSetup.Get();
        SupplierGrouping.Get("Request No.", "Vendor No.");

        if SupplierGrouping."Total Amount" > PurchSetup."Threshold Amount" then begin
            case "Approval Level" of
                1:
                    begin
                        if Decision then
                            SupplierGrouping.Status := SupplierGrouping.Status::"Pending Approval"
                        else
                            SupplierGrouping.Status := SupplierGrouping.Status::Rejected;
                    end;
                2:
                    begin
                        if Decision then
                            SupplierGrouping.Status := SupplierGrouping.Status::Approved
                        else
                            SupplierGrouping.Status := SupplierGrouping.Status::Rejected;
                    end;
            end;
        end else begin
            if Decision then
                SupplierGrouping.Status := SupplierGrouping.Status::Approved
            else
                SupplierGrouping.Status := SupplierGrouping.Status::Rejected;
        end;
        SupplierGrouping.Modify(true);
    end;
}