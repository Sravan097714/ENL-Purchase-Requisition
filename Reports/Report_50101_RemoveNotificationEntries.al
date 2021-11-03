report 50101 "Remove Notification Entries"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {

    }

    requestpage
    {
        layout
        {

        }


    }



    trigger OnPostReport()
    var
        NotifiactionEntries: Record "Notification Entry";
    begin
        NotifiactionEntries.DeleteAll();
    end;
}