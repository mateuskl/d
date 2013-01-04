// Author: mateuskl
import core.thread;
import core.sync.semaphore;
import core.sync.mutex;
import std.stdio;

class Philosopher : Thread
{
public:    
    this(uint n, uint iterations, Mutex table, Semaphore[] chopsticks)
    {
        super(&run);
        
        __n = n;
        __iterations = iterations;
        __times_that_ate = 0;
        __table = table;
        __chopsticks = chopsticks;
    }

public @property uint times_that_ate() { return __times_that_ate; }
    
private:
    void run()
    {
        uint first = (__n < 4)? __n : 0;
        uint second = (__n < 4)? __n + 1 : 4;
        for(uint i = __iterations; i > 0; i--)
        {
            __table.lock();
            writeln("Philosopher: ", __n, " thinking");
            __table.unlock();
            Thread.sleep( dur!("msecs")( 2000 ) );  // Delay thinking: 2000 milliseconds

            __chopsticks[first].wait();   // get first chopstick
            __chopsticks[second].wait();   // get second chopstick

            __table.lock();            
            writeln("Philosopher: ", __n, " eating");
            __table.unlock();            
            Thread.sleep( dur!("seconds")( 1 ) ); // Delay eating: 1 second

            __chopsticks[first].notify();   // release first chopstick
            __chopsticks[second].notify();   // release second chopstick

            __times_that_ate ++;
        }

        __table.lock();
        writeln("Philosopher: ", __n, " done");
        __table.unlock();        
    }

    private uint __n;
    private uint __iterations;
    private uint __times_that_ate;
    private Mutex __table;
    private Semaphore[] __chopsticks;

}

void main()
{
    const uint iterations = 10;

    Philosopher phil[5];
    Semaphore chopsticks[5];
    Mutex table = new Mutex();

    table.lock();    
    writeln("The Dining Philosopher's:");

    for(int i = 0; i < 5; i++)
    {
        chopsticks[i] = new Semaphore(1);
        phil[i] = new Philosopher(i, iterations, table, chopsticks);
    }

    for(int i = 0; i < 5; i++)
    {
        phil[i].start();
    }
    writeln("Philosophers are alive and hungry!");
    
    writeln("The dinner is served ...");
    table.unlock();

    

    for(int i = 0; i < 5; i++)
    {
        phil[i].join();        
    }

    for(int i = 0; i < 5; i++)
    {
        table.lock();        
        writeln("Philosopher ", i, " ate ", phil[i].times_that_ate, " times");
        table.unlock();
    }

    writeln("The end!");
}
