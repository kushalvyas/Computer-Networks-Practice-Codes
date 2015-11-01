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


# so till here we have defined nodes and links
# now lets define how will we be sending the data
# create and attach a UDP Agent
set udp0 [new Agent/UDP] 
$ns attach-agent $n0 $udp0 
# connect the node to the udp agent

# now we have established connection.. just need to add traffic
# so we createa a CBR traffic source 	
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 	500
$cbr0 set interval_ 0.005
$cbr0 attach-agent $udp0

# so now we have a source of sending data
# so we will need a sink as well
# to maintain proper flow of data
set null0 [new Agent/Null]
$ns attach-agent $n1 $null0	

# Therefore $n0 is a sending node and  $n1 is a receiving node
# lets connect the two 
$ns connect $udp0 $null0


# now we start writing the animation ka part
# start animation of $cbr0 at 0.5 seconds 
$ns at 0.5 "$cbr0 start" 
# end at 4.5 seconds
$ns at 4.5 "$cbr0 stop"


$ns run


# This file is the basic skeleton for ns2 files