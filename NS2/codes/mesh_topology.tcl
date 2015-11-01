#create a simulator object
set ns [new Simulator]

#step2:open a nam file. s1 is the name of .nam file that will be created 
set nf [open out.nam w]  
$ns namtrace-all $nf



#step 5: define nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]

#step 6: define links 
$ns duplex-link $n0 $n1 1Mb 10ms DropTail
$ns duplex-link $n0 $n2 1Mb 10ms DropTail
$ns duplex-link $n0 $n3 1Mb 10ms DropTail


$ns duplex-link $n1 $n2 1Mb 10ms DropTail
$ns duplex-link $n1 $n3 1Mb 10ms DropTail
$ns duplex-link $n1 $n4 1Mb 10ms DropTail

$ns duplex-link $n2 $n3 1Mb 10ms DropTail
$ns duplex-link $n2 $n4 1Mb 10ms DropTail
$ns duplex-link $n3 $n4 1Mb 10ms DropTail

$ns duplex-link $n4 $n0 1Mb 10ms DropTail
#step 7:create udp agents for each source
set udp0 [new Agent/UDP]
$ns attach-agent $n0 $udp0
set udp02 [new Agent/UDP]
$ns attach-agent $n0 $udp02
set udp03 [new Agent/UDP]
$ns attach-agent $n0 $udp03

set udp1 [new Agent/UDP]
$ns attach-agent $n1 $udp1
set udp13 [new Agent/UDP]
$ns attach-agent $n1 $udp13
set udp14 [new Agent/UDP]
$ns attach-agent $n1 $udp14
set udp2 [new Agent/UDP]
$ns attach-agent $n2 $udp2
set udp24 [new Agent/UDP]
$ns attach-agent $n2 $udp24
set udp3 [new Agent/UDP]
$ns attach-agent $n3 $udp3
set udp4 [new Agent/UDP]
$ns attach-agent $n4 $udp4

#step 8: create cbr for each udp. traffic shit
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_	500
$cbr0 set interval_	0.005
$cbr0 attach-agent $udp0


set cbr02 [new Application/Traffic/CBR]
$cbr02 set packetSize_	500
$cbr02 set interval_	0.005
$cbr02 attach-agent $udp02


set cbr03 [new Application/Traffic/CBR]
$cbr03 set packetSize_	500
$cbr03 set interval_	0.005
$cbr03 attach-agent $udp03

set cbr1 [new Application/Traffic/CBR]
$cbr1 set packetSize_	500
$cbr1 set interval_	0.005
$cbr1 attach-agent $udp1


set cbr13 [new Application/Traffic/CBR]
$cbr13 set packetSize_	500
$cbr13 set interval_	0.005
$cbr13 attach-agent $udp13

set cbr14 [new Application/Traffic/CBR]
$cbr14 set packetSize_	500
$cbr14 set interval_	0.005
$cbr14 attach-agent $udp14

set cbr2 [new Application/Traffic/CBR]
$cbr2 set packetSize_	500
$cbr2 set interval_	0.005
$cbr2 attach-agent $udp2


set cbr24 [new Application/Traffic/CBR]
$cbr24 set packetSize_	500
$cbr24 set interval_	0.005
$cbr24 attach-agent $udp24

set cbr3 [new Application/Traffic/CBR]
$cbr3 set packetSize_	500
$cbr3 set interval_	0.005
$cbr3 attach-agent $udp3

set cbr4 [new Application/Traffic/CBR]
$cbr4 set packetSize_	500
$cbr4 set interval_	0.005
$cbr4 attach-agent $udp4

#step 9:Null agents(something to do with the sinks)
set null0 [new Agent/Null]
$ns attach-agent $n0 $null0
set null02 [new Agent/Null]
$ns attach-agent $n2 $null02

set null03 [new Agent/Null]
$ns attach-agent $n3 $null03

set null1 [new Agent/Null]
$ns attach-agent $n1 $null1

set null13 [new Agent/Null]
$ns attach-agent $n3 $null13

set null14 [new Agent/Null]
$ns attach-agent $n4 $null14


set null2 [new Agent/Null]
$ns attach-agent $n2 $null2


set null24 [new Agent/Null]
$ns attach-agent $n4 $null24
set null3 [new Agent/Null]
$ns attach-agent $n3 $null3
set null4 [new Agent/Null]
$ns attach-agent $n4 $null4
set null5 [new  Agent/Null]
$ns attach-agent $n3 $null5
#step 10: connecting source and sinks
$ns connect $udp0 $null1
$ns connect $udp02 $null02
$ns connect $udp03 $null03
$ns connect $udp1 $null2
$ns connect $udp13 $null13
$ns connect $udp14 $null14
$ns connect $udp2 $null3
$ns connect $udp24 $null24
$ns connect $udp3 $null4
$ns connect $udp4 $null0

#step 11:schedule the events
$ns at 0 "$cbr0 start"
$ns at 4.5 "$cbr0 stop"

$ns at 0 "$cbr02 start"
$ns at 4.5 "$cbr02 stop"

$ns at 0 "$cbr03 start"
$ns at 4.5 "$cbr03 stop"

$ns at 0 "$cbr1 start"
$ns at 4.5 "$cbr1 stop"

$ns at 0 "$cbr13 start"
$ns at 4.5 "$cbr13 stop"

$ns at 0 "$cbr14 start"
$ns at 4.5 "$cbr14 stop"

$ns at 0 "$cbr2 start"
$ns at 4.5 "$cbr2 stop"


$ns at 0 "$cbr24 start"
$ns at 4.5 "$cbr24 stop"

$ns at 0 "$cbr3 start"
$ns at 4.5 "$cbr3 stop"

$ns at 0 "$cbr4 start"
$ns at 4.5 "$cbr4 stop"


#run
$ns run
