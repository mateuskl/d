interface Outer
{
    interface Inner
    {
        void foo();
    }
}


class Inner_Imp : Outer.Inner
{
    void foo() {}
}

void main()
{
    Outer.Inner a = new Inner_Imp();
}

