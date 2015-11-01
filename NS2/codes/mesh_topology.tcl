# create simulator
set ns [new Simulator]

set nf [open out.nam w]
$ns namtrace-all $nf

# define nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]

# defining link
# for node 0
$ns duplex-link $n0 $n1 1Mb 10ms DropTail
$ns duplex-link $n0 $n2 1Mb 10ms DropTail
$ns duplex-link $n0 $n3 1Mb 10ms DropTail
$ns duplex-link $n0 $n4 1Mb 10ms DropTail
# for node 1
$ns duplex-link $n1 $n2 1Mb 10ms DropTail
$ns duplex-link $n1 $n3 1Mb 10ms DropTail
# for node 2
$ns duplex-link $n2 $n4 1Mb 10ms DropTail
# for node 3
$ns duplex-link $n3 $n4 1Mb 10ms DropTail

# making udp agent 
set udp0 [new Agent/UDP]
set udp01 [new Agent/UDP]
set udp02 [new Agent/UDP]
set udp03 [new Agent/UDP]
set udp04 [new Agent/UDP]

set udp12 [new Agent/UDP]
set udp13 [new Agent/UDP]

# 
set udp21 [new Agent/UDP]
set udp3 [new Agent/UDP]
set udp4 [new Agent/UDP]

# attach with respective node
$ns attach-agent $n0 $udp0
$ns attach-agent $n0 $udp01
$ns attach-agent $n0 $udp02
$ns attach-agent $n0 $udp03
$ns attach-agent $n0 $udp04

$ns attach-agent $n1 $udp12
$ns attach-agent $n1 $udp13

$ns attach-agent $n2 $udp21
$ns attach-agent $n3 $udp3
$ns attach-agent $n4 $udp4

# set cbr traffic
# set for the 0 node
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 500
$cbr0 set interval_ 0.005
$cbr0 attach-agent $udp0

set cbr01 [new Application/Traffic/CBR]
$cbr01 set packetSize_ 500
$cbr01 set interval_ 0.005
$cbr01 attach-agent $udp01

set cbr02 [new Application/Traffic/CBR]
$cbr02 set packetSize_ 500
$cbr02 set interval_ 0.005
$cbr02 attach-agent $udp02

set cbr03 [new Application/Traffic/CBR]
$cbr03 set packetSize_ 500
$cbr03 set interval_ 0.005
$cbr03 attach-agent $udp03

set cbr04 [new Application/Traffic/CBR]
$cbr04 set packetSize_ 500
$cbr04 set interval_ 0.005
$cbr04 attach-agent $udp04

# node 1
set cbr12 [new Application/Traffic/CBR]
$cbr12 set packetSize_ 500
$cbr12 set interval_ 0.005
$cbr12 attach-agent $udp12

set cbr13 [new Application/Traffic/CBR]
$cbr13 set packetSize_ 500
$cbr13 set interval_ 0.005
$cbr13 attach-agent $udp13

# for 2
set cbr21 [new Application/Traffic/CBR]
$cbr21 set packetSize_ 500
$cbr21 set interval_ 0.005
$cbr21 attach-agent $udp21

# set null ..
# wrt node 0
set null01 [new Agent/Null]
set null02 [new Agent/Null]
set null03 [new Agent/Null]
set null04 [new Agent/Null]

# wrt node 1
set null12 [new Agent/Null]
set null13 [new Agent/Null]

# wrt node 2
set null21 [new Agent/Null]

# assign null to the sockets
$ns attach-agent $n1 $null01
$ns attach-agent $n2 $null02
$ns attach-agent $n3 $null03
$ns attach-agent $n4 $null04

$ns attach-agent $n1 $null21

$ns attach-agent $n2 $null12
$ns attach-agent $n3 $null13




# make connections 
# $ns connect 
$ns connect $udp01 $null01
$ns connect $udp02 $null02
$ns connect $udp03 $null03
$ns connect $udp04 $null04

$ns connect $udp12 $null12
$ns connect $udp13 $null13

$ns connect $udp21 $null21
# write animation

# $ns at 1.1 "$cbr0 start"
$ns at 1.0 "$cbr01 start"
$ns at 1.0 "$cbr02 start"
$ns at 1.0 "$cbr03 start"
$ns at 1.1 "$cbr04 start"
$ns at 2.1 "$cbr12 start"
$ns at 2.1 "$cbr13 start"
$ns at 2.1 "$cbr21 start"

$ns at 4.0 "$cbr01 stop"
$ns at 4.0 "$cbr02 stop"
$ns at 4.0 "$cbr03 stop"
$ns at 4.0 "$cbr04 stop"
$ns at 4.0 "$cbr12 stop"
$ns at 4.0 "$cbr13 stop"
$ns at 4.0 "$cbr21 stop"

$ns run