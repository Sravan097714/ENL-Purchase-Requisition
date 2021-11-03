page 50095 "Purchase Category Initiator"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = "Purchase Category Initiator";

    layout
    {
        area(Content)
        {
            repeater(List)
            {
                field(Category; Category)
                {
                    ApplicationArea = All;
                }
                field(Initiator; Initiator)
                {
                    ApplicationArea = All;
                }
                field("Initiator Name"; "Initiator Name")
                {
                    ApplicationArea = All;
                }
                field("Purchase Order Nos."; "Purchase Order Nos.")
                {
                    ApplicationArea = All;
                }
                field("Purchase Invoice Nos."; Rec."Purchase Invoice Nos.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}