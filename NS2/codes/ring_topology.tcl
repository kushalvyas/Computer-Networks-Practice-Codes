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
# since we have 7 nodes... it's pretty long to write down statements 
# so we will use the for loop
for {set i 0 } {$i < 7}  {incr i} {
	set n($i) [$ns node]
}

# define link
for {set i 0} {$i < 7} {incr i} {
	$ns duplex-link $n($i) $n([expr ($i+1)%7]) 1Mb 10ms DropTail
}

# defining udp agent
for {set i 0} {$i < 7} {incr i} {
	set udp($i) [new Agent/UDP]
	$ns attach-agent $n($i) $udp($i)
}


# defining cbr for traffic
for {set i 0} { $i < 7} {incr i} {
	set cbr($i) [new Application/Traffic/CBR]
	$cbr($i) set packetSize_ 	500
	$cbr($i) set interval_ 0.005
	$cbr($i) attach-agent $udp($i)
}

# defining source and sink
# so in ring topo .. every node acts as a source and sink
for {set i 0} {$i < 7} {incr i} {
	
	set null($i) [new Agent/Null]
	$ns attach-agent $n($i) $null($i)
}

# making conncections!
$ns connect $udp(0) $null(1)
$ns connect $udp(1) $null(2)
$ns connect $udp(2) $null(3)
$ns connect $udp(3) $null(4)
$ns connect $udp(4) $null(5)
$ns connect $udp(5) $null(6)
$ns connect $udp(6) $null(0)

# start animation
$ns at 0.1 "$cbr(0) start"
$ns at 0.1 "$cbr(1) start"
$ns at 0.1 "$cbr(2) start"
$ns at 0.1 "$cbr(3) start"
$ns at 0.1 "$cbr(4) start"
$ns at 0.1 "$cbr(5) start"
$ns at 0.1 "$cbr(6) start"

$ns at 4 "$cbr(0) stop"
$ns at 4 "$cbr(1) stop"
$ns at 4 "$cbr(2) stop"
$ns at 4 "$cbr(3) stop"
$ns at 4 "$cbr(4) stop"
$ns at 4 "$cbr(5) stop"
$ns at 4 "$cbr(6) stop"



$ns run


# This file is the basic skeleton for ns2 files