/* Alpha is a derived thread
 * Beta is a composed thread
 *
 *  */

import core.thread;
import std.stdio;

class Alpha : Thread
{
public:    
    this(uint iterations)
    {
        super(&run);
        __iterations = iterations;
    }

private:
    void run()
    {        
        for (uint i = 0; i < __iterations; i++)
        {
            write("A");
            // yield();
        }
    }

private:
    uint __iterations;
}


int beta_iterations = 10000;

void betaFunc()
{    
    for (uint i = 0; i < beta_iterations; i++)
    {
        write("B");
        // Thread.yield();
    }
}

void main()
{
    Alpha alpha = new Alpha(10000);
    Thread beta = new Thread(&betaFunc);

    beta.start();
    alpha.start();
}
