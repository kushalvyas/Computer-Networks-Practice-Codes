# bus topology implementation using udp
# create ns object
set ns [new Simulator]

# open trace file as write mode
set nf [open out.nam w]

$ns namtrace-all $nf

# ### basic init is done
# lets start with nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n11 [$ns node]
set n22 [$ns node]
set n33 [$ns node]
set n44 [$ns node]

# lets make the links

$ns duplex-link $n0 $n1 1Mb 10ms DropTail
$ns duplex-link $n1 $n11 1Mb 10ms DropTail
$ns duplex-link $n1 $n2 1Mb 10ms DropTail
$ns duplex-link $n2 $n22 1Mb 10ms DropTail
$ns duplex-link $n2 $n3 1Mb 10ms DropTail
$ns duplex-link $n3 $n33 1Mb 10ms DropTail
$ns duplex-link $n3 $n4 1Mb 10ms DropTail
$ns duplex-link $n4 $n44 1Mb 10ms DropTail
$ns duplex-link $n4 $n5 1Mb 10ms DropTail


# set udp agent for each of the nodes
set udp0 [new Agent/UDP]
# attach it to the node
$ns attach-agent $n0 $udp0

# similarly do for all nodes
set udp1 [new Agent/UDP]
$ns attach-agent $n1 $udp1
set udp11 [new Agent/UDP]
$ns attach-agent $n1 $udp11

set udp2 [new Agent/UDP]
$ns attach-agent $n2 $udp2
set udp22 [new Agent/UDP]
$ns attach-agent $n2 $udp22

set udp3 [new Agent/UDP]
$ns attach-agent $n3 $udp3
set udp33 [new Agent/UDP]
$ns attach-agent $n3 $udp33

set udp4 [new Agent/UDP]
$ns attach-agent $n4 $udp4
set udp44 [new Agent/UDP]
$ns attach-agent $n4 $udp44

set udp5 [new Agent/UDP]
$ns attach-agent $n5 $udp5


# now define cbr 
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 500
$cbr0 set interval_ 0.005
$cbr0 attach-agent $udp0

set cbr1 [new Application/Traffic/CBR]
$cbr1 set packetSize_ 500
$cbr1 set interval_ 0.005
$cbr1 attach-agent $udp1

set cbr11 [new Application/Traffic/CBR]
$cbr11 set packetSize_ 500
$cbr11 set interval_ 0.005
$cbr11 attach-agent $udp11

set cbr2 [new Application/Traffic/CBR]
$cbr2 set packetSize_ 500
$cbr2 set interval_ 0.005
$cbr2 attach-agent $udp2

set cbr22 [new Application/Traffic/CBR]
$cbr22 set packetSize_ 500
$cbr22 set interval_ 0.005
$cbr22 attach-agent $udp22

set cbr3 [new Application/Traffic/CBR]
$cbr3 set packetSize_ 500
$cbr3 set interval_ 0.005
$cbr3 attach-agent $udp3

set cbr33 [new Application/Traffic/CBR]
$cbr33 set packetSize_ 500
$cbr33 set interval_ 0.005
$cbr33 attach-agent $udp33

set cbr4 [new Application/Traffic/CBR]
$cbr4 set packetSize_ 500
$cbr4 set interval_ 0.005
$cbr4 attach-agent $udp4

set cbr44 [new Application/Traffic/CBR]
$cbr44 set packetSize_ 500
$cbr44 set interval_ 0.005
$cbr44 attach-agent $udp44

set cbr5 [new Application/Traffic/CBR]
$cbr5 set packetSize_ 500
$cbr5 set interval_ 0.005
$cbr5 attach-agent $udp5

# define sinks and null..
set null0 [new Agent/Null]
$ns attach-agent $n0 $null0

set null1 [new Agent/Null]
$ns attach-agent $n1 $null1
set null11 [new Agent/Null]
$ns attach-agent $n11 $null11

set null2 [new Agent/Null]
$ns attach-agent $n2 $null2
set null22 [new Agent/Null]
$ns attach-agent $n22 $null22

set null3 [new Agent/Null]
$ns attach-agent $n3 $null3
set null33 [new Agent/Null]
$ns attach-agent $n33 $null33

set null4 [new Agent/Null]
$ns attach-agent $n4 $null4
set null44 [new Agent/Null]
$ns attach-agent $n44 $null44

set null5 [new Agent/Null]
$ns attach-agent $n5 $null5

# connections
$ns connect $udp0 $null5
$ns connect $udp1 $null11
$ns connect $udp2 $null22
$ns connect $udp3 $null33 
$ns connect $udp4 $null44

# start animation
$ns at 1.0 "$cbr0 start"
$ns at 1.0 "$cbr1 start"
$ns at 1.0 "$cbr2 start"
$ns at 1.0 "$cbr3 start"
$ns at 1.0 "$cbr4 start"


$ns at 4.0 "$cbr0 stop"
$ns at 4.0 "$cbr1 stop"
$ns at 4.0 "$cbr2 stop"
$ns at 4.0 "$cbr3 stop"
$ns at 4.0 "$cbr4 stop"


$ns run
