# create a simulator object
set ns [new Simulator]

# create a file for writing nam trace data
# filename : out.nam in 'w'=> write mode
set nf [open out.nam w] 

# put $ns  that is the simulator object ka trace in $nf .. that is
# put $ns ka all operations in $nf (the file)
$ns namtrace-all $nf

##################### for all your programs.. your code goes here ##############################
# create the nodes first
set n0 [$ns node]
set n1 [$ns node]


# define link
$ns duplex-link $n0 $n1 1Mb 10ms DropTail



$ns run


# This file is the basic skeleton for ns2 files