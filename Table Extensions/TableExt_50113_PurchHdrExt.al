tableextension 50113 PurchHdrExtPR extends "Purchase Header"
{
    fields
    {
        field(60000; "Request No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        //Added By Cedric Dominique - 04.06.2021
        field(60001; "Iniator"; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Processed By';
            Editable = false;
        }
        field(60002; "Web Approver"; Text[150])
        {

            Caption = 'Web Approver';
            Editable = false;
        }
        field(60003; VendorInv_No; Code[35])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Purchase Requisition Header".VendorInvNo where("Request No." = field("Request No.")));
        }
        field(60004; ShortcutDimension2Code; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Purchase Requisition Header"."Shortcut Dimension 2 Code" where("Request No." = field("Request No.")));
        }
        modify("Purchaser Code")
        {
            Caption = 'PO Department Approver';
        }
        //End By Cedric Dominique - 04.06.2021
        field(60005; Archive; Boolean)
        {
            FieldClass = Normal;
            Caption = 'Archive';
        }
        /*
         field(60010; "Archive Version No."; Integer)
         {
             DataClassification = ToBeClassified;
         }
         field(60011; "Last Restored Archive Version"; Integer)
         {
             DataClassification = ToBeClassified;
         }
         field(60012; Select; Integer)
         {
             DataClassification = ToBeClassified;
         } */
    }
}

