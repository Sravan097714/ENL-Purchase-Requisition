pageextension 50120 GLAccCardExt extends "G/L Account Card"
{
    layout
    {
        addlast(General)
        {
            field("Global Dimension 1 Code"; "Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
            field("Purchase Type"; "Purchase Type")
            {
                ApplicationArea = All;
            }
        }
    }
}