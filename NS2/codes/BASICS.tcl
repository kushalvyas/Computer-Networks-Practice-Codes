# create a simulator object
set ns [new Simulator]

# create a file for writing nam trace data
# filename : out.nam in 'w'=> write mode
set nf [open out.nam w] 

# put $ns  that is the simulator object ka trace in $nf .. that is
# put $ns ka all operations in $nf (the file)
$ns namtrace-all $nf

##################### for all your programs.. your code goes here ##############################

$ns run


# This file is the basic skeleton for ns2 files