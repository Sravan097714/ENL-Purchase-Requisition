enum 50016 "Request Line Status"
{
    Extensible = true;

    value(0; Open) { }
    value(1; "Pending Approval") { }
    value(2; Approved) { }
    value(3; Rejected) { }
}