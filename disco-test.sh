#!/bin/sh
s=0.2s
for i in $(seq 1 10);do
./leds_st1202.sh +r
sleep $s
./leds_st1202.sh -r
sleep $s
./leds_st1202.sh +g
sleep $s
./leds_st1202.sh -g
sleep $s
./leds_st1202.sh +b
sleep $s
./leds_st1202.sh -b
sleep $s
./leds_st1202.sh +m
sleep $s
./leds_st1202.sh -m
sleep $s
./leds_st1202.sh +y
sleep $s
./leds_st1202.sh -y
sleep $s
./leds_st1202.sh +c
sleep $s
./leds_st1202.sh -c
sleep $s
./leds_st1202.sh +m
sleep $s
./leds_st1202.sh -m
sleep $s
./leds_st1202.sh +w
sleep $s
./leds_st1202.sh -w
sleep $s
done
