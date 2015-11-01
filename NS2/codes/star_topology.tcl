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
set n2 [$ns node]
set n3 [$ns node]
set hub [$ns node]



# define link
# since we are using star topology .. every node will be connected to the hub
# and all the data transfers have to go through the hub from one node toanother
$ns duplex-link $hub $n0 1Mb 10ms DropTail	
$ns duplex-link $hub $n1 1Mb 10ms DropTail
$ns duplex-link $hub $n2 1Mb 10ms DropTail
$ns duplex-link $hub $n3 1Mb 10ms DropTail


# lets setup connection agents ...
set udp0 [new Agent/UDP]
set udp1 [new Agent/UDP]

# lets attach agents
$ns attach-agent $n0 $udp0
$ns attach-agent $n1 $udp1


# lets provide traffic
# for udp0
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 	500
$cbr0 set interval_ 0.005
$cbr0 attach-agent $udp0

# for udp1
set cbr1 [new Application/Traffic/CBR]
$cbr1 set packetSize_ 	500
$cbr1 set interval_ 0.005
$cbr1 attach-agent $udp1



#######
# now that we have established the design of the topology , lets define source and sink
set null2 [new Agent/Null]
$ns attach-agent $n2 $null2
set null3 [new Agent/Null]
$ns attach-agent $n3 $null3


# now make connections. socket to socket wise
$ns connect $udp0 $null2
$ns connect $udp1 $null3



# now we start writing the animation ka part
# start animation of $cbr0 at 0.5 seconds 
$ns at 0.5 "$cbr0 start" 
$ns at 1.0 "$cbr1 start"
$ns at 4.0 "$cbr1 stop"
$ns at 4.5 "$cbr0 stop"

$ns run

