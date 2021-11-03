enum 50015 "Request Header Status"
{
    Extensible = true;

    value(0; Open) { }
    value(1; "Pending Approval") { }
    value(2; Approved) { }
    value(3; "Partly Approved") { }
    value(4; Rejected) { }
    value(5; Completed) { }
}