page 50119 "ApprovalEntriesBasePageAppOp"
{
    ApplicationArea = Suite;
    Caption = 'Approval Entries';
    Editable = false;
    PageType = ListPart;
    SourceTable = "Approval Entry";
    SourceTableView = sorting("Approver ID", Status, "Due Date", "Date-Time Sent for Approval")
    order(ascending) where(Status = filter(Approved | Open));
    UsageCategory = Lists;
    //SORTING("Table ID",, "Document Type", "Document No.", "Date-Time Sent for Approval")
    //ORDER(Ascending);
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                Editable = false;
                field(Overdue; Overdue)
                {
                    ApplicationArea = Suite;
                    Caption = 'Overdue';
                    Editable = false;
                    ToolTip = 'Specifies that the approval is overdue.';
                    visible = false;
                }
                field("Table ID"; "Table ID")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the ID of the table where the record that is subject to approval is stored.';
                    Visible = false;
                }
                field("Limit Type"; "Limit Type")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the type of limit that applies to the approval template:';
                    visible = false;
                }
                field("Approval Type"; "Approval Type")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies which approvers apply to this approval template:';
                    visible = false;
                }
                field("Document Type"; "Document Type")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the type of document that an approval entry has been created for. Approval entries can be created for six different types of sales or purchase documents:';
                    Visible = false;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the document number copied from the relevant sales or purchase document, such as a purchase order or a sales quote.';

                }
                field(RecordIDText; RecordIDText)
                {
                    ApplicationArea = Suite;
                    Caption = 'To Approve';
                    ToolTip = 'Specifies the record that you are requested to approve.';
                    visible = false;
                }
                field(Details; RecordDetails)
                {
                    ApplicationArea = Suite;
                    Caption = 'Details';
                    ToolTip = 'Specifies the record that the approval is related to.';

                }
                field("Sequence No."; "Sequence No.")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the order of approvers when an approval workflow involves more than one approver.';
                }
                field(Status; Status)
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the approval status for the entry:';
                }
                field("Approver ID"; "Approver ID")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the ID of the user who must approve the document.';
                    Visible = false;

                    trigger OnDrillDown()
                    var
                        UserMgt: Codeunit "User Management";
                    begin
                        UserMgt.DisplayUserInformation("Approver ID");
                    end;
                }
                field(SenderName; SenderName) { ApplicationArea = all; Editable = false; }
                field(approvname; approvname) { ApplicationArea = all; Editable = false; }
                field("Sender ID"; "Sender ID")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the ID of the user who sent the approval request for the document to be approved.';
                    visible = false;

                    trigger OnDrillDown()
                    var
                        UserMgt: Codeunit "User Management";
                    begin
                        UserMgt.DisplayUserInformation("Sender ID");
                    end;
                }

                field("Salespers./Purch. Code"; "Salespers./Purch. Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the code for the salesperson or purchaser that was in the document to be approved. It is not a mandatory field, but is useful if a salesperson or a purchaser responsible for the customer/vendor needs to approve the document before it is processed.';
                    visible = false;
                }

                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the code of the currency of the amounts on the sales or purchase lines.';

                }
                field("Amount (LCY)"; "Amount (LCY)")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the total amount (excl. VAT) on the document awaiting approval. The amount is stated in the local currency.';

                }
                field("Available Credit Limit (LCY)"; "Available Credit Limit (LCY)")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the remaining credit (in LCY) that exists for the customer.';
                    visible = false;
                }
                field("Date-Time Sent for Approval"; "Date-Time Sent for Approval")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the date and the time that the document was sent for approval.';
                }
                field("Last Date-Time Modified"; "Last Date-Time Modified")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the date when the approval entry was last modified. If, for example, the document approval is canceled, this field will be updated accordingly.';
                }
                field("Last Modified By User ID"; "Last Modified By User ID")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the ID of the user who last modified the approval entry. If, for example, the document approval is canceled, this field will be updated accordingly.';
                    Visible = false;

                    trigger OnDrillDown()
                    var
                        UserMgt: Codeunit "User Management";
                    begin
                        UserMgt.DisplayUserInformation("Last Modified By User ID");
                    end;
                }
                field(lastusername; lastusername) { ApplicationArea = all; Editable = false; Caption = 'Last Modified By'; }
                field(poapprovername; poapprovername) { ApplicationArea = all; Editable = false; Visible = false; }
                field(piapprovername; piapprovername) { ApplicationArea = all; Editable = false; Visible = false; }
                field(Comment; Comment)
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies whether there are comments relating to the approval of the record. If you want to read the comments, choose the field to open the Approval Comment Sheet window.';

                }
                field("Due Date"; "Due Date")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies when the record must be approved, by one or more approvers.';

                }
            }
        }
        /* area(factboxes)
         {
             part(Change; "Workflow Change List FactBox")
             {
                 ApplicationArea = Suite;
                 Editable = false;
                 Enabled = false;
                 ShowFilter = false;
                 UpdatePropagation = SubPart;
                 Visible = ShowChangeFactBox;
             }
             systempart(Control5; Links)
             {
                 ApplicationArea = RecordLinks;
                 Visible = false;
             }
             systempart(Control4; Notes)
             {
                 ApplicationArea = Notes;
                 Visible = true;
             }
         }
         */
    }

    actions
    {
        /*area(navigation)
        {
            group("&Show")
            {
                Caption = '&Show';
                Image = View;
                action("Record")
                {
                    ApplicationArea = Suite;
                    Caption = 'Record';
                    Enabled = ShowRecCommentsEnabled;
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Open the document, journal line, or card that the approval request is for.';

                    trigger OnAction()
                    begin
                        ShowRecord;
                    end;
                }
                action(Comments)
                {
                    ApplicationArea = Suite;
                    Caption = 'Comments';
                    Enabled = ShowRecCommentsEnabled;
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'View or add comments for the record.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        RecRef: RecordRef;
                    begin
                        RecRef.Get("Record ID to Approve");
                        Clear(ApprovalsMgmt);
                        ApprovalsMgmt.GetApprovalCommentForWorkflowStepInstanceID(RecRef, "Workflow Step Instance ID");
                    end;
                }
                action("O&verdue Entries")
                {
                    ApplicationArea = Suite;
                    Caption = 'O&verdue Entries';
                    Image = OverdueEntries;
                    ToolTip = 'View approval requests that are overdue.';

                    trigger OnAction()
                    begin
                        SetFilter(Status, '%1|%2', Status::Created, Status::Open);
                        SetFilter("Due Date", '<%1', Today);
                    end;
                }
                action("All Entries")
                {
                    ApplicationArea = Suite;
                    Caption = 'All Entries';
                    Image = Entries;
                    ToolTip = 'View all approval entries.';

                    trigger OnAction()
                    begin
                        SetRange(Status);
                        SetRange("Due Date");
                    end;
                }
            }
        }
        area(processing)
        {
            action("&Delegate")
            {
                ApplicationArea = Suite;
                Caption = '&Delegate';
                Enabled = DelegateEnable;
                Image = Delegate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Delegate the approval request to another approver that has been set up as your substitute approver.';

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    CurrPage.SetSelectionFilter(ApprovalEntry);
                    ApprovalsMgmt.DelegateApprovalRequests(ApprovalEntry);
                end;
            }
        }*/
    }

    /* trigger OnAfterGetCurrRecord()
     var
         RecRef: RecordRef;
     begin
         ShowChangeFactBox := CurrPage.Change.PAGE.SetFilterFromApprovalEntry(Rec);
         DelegateEnable := CanCurrentUserEdit;
         ShowRecCommentsEnabled := RecRef.Get("Record ID to Approve");
     end;
     */

    trigger OnAfterGetRecord()
    var
        userrec: Record user;
        vendorledgerentryrec: Record "Vendor Ledger Entry";
    begin
        Overdue := Overdue::" ";
        if FormatField(Rec) then
            Overdue := Overdue::Yes;

        RecordIDText := Format("Record ID to Approve", 0, 1);


        userrec.Reset();
        userrec.SetRange("User Name", "Approver ID");
        if userrec.FindFirst then
            approvname := userrec."Full Name";

        userrec.Reset();
        userrec.SetRange("User Name", "Sender ID");
        if userrec.FindFirst then
            sendername := userrec."Full Name";

        userrec.Reset();
        userrec.SetRange("User Name", "Last Modified By User ID");
        if userrec.FindFirst then
            lastusername := userrec."Full Name";





    end;

    trigger OnOpenPage()
    begin
        // MarkAllWhereUserisApproverOrSender;
    end;

    var
        Overdue: Option Yes," ";
        RecordIDText: Text;
        ShowChangeFactBox: Boolean;
        DelegateEnable: Boolean;
        ShowRecCommentsEnabled: Boolean;
        approvname: Text[50];
        sendername: Text[50];
        lastusername: Text[50];
        poapproverid: Text[50];
        piapproverid: Text[50];
        poapprovername: Text[50];
        piapprovername: Text[50];

    procedure Setfilters(TableId: Integer; DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; DocumentNo: Code[20])
    begin
        if TableId <> 0 then begin
            FilterGroup(2);
            SetCurrentKey("Table ID", "Document Type", "Document No.", "Date-Time Sent for Approval");
            SetRange("Table ID", TableId);
            SetRange("Document Type", DocumentType);
            if DocumentNo <> '' then
                SetRange("Document No.", DocumentNo);
            FilterGroup(0);
        end;
    end;

    local procedure FormatField(ApprovalEntry: Record "Approval Entry"): Boolean
    begin
        if Status in [Status::Created, Status::Open] then begin
            if ApprovalEntry."Due Date" < Today then
                exit(true);

            exit(false);
        end;
    end;

    procedure CalledFrom()
    begin
        Overdue := Overdue::" ";
    end;
}

