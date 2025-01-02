#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright (C) 2024, Manuel Fombuena <fombuena@outlook.com>
#
# leds_st1202.sh - Shell script to manage RGB LEDs on ST LED1202.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#

### HELP STARTS ###
usage() {
  echo "
 Shell script to manage RGB LEDs on the ST LED1202 controller.
 Operations on the LEDs are additive e.g. +r will result in red if
 green and blue are off, and otherwise the result of it combined
 with whichever other LED is also on.

 SYNTAX

 leds_st1202.sh [+r|+g|+b|+c|+m|+y|+w|-r|-g|-b|-c|-m|-y|-w|-o]

 OPTIONS

 ++red|+r
   Turn on red LED.

 --red|-r
   Turn off red LED.

 ++green|+g
   Turn on green LED.

 --green|-g
   Turn off green LED.

 ++blue|+b
   Turn on blue LED.

 --blue|-b
   Turn off blue LED.

 ++cyan|+c
   Turn on green blue LEDs.

 --cyan|-c
   Turn off green blue LEDs.

 ++magenta|+m
   Turn on red blue LEDs.

 --magenta|-m
   Turn off red blue LEDs.

 ++yellow|+y
   Turn on red green LEDs.

 --yellow|-y
   Turn off red green LEDs.

 ++white|+w
   Turn on red green blue LEDs.

 --white|-w
   Turn off red green blue LEDs.

 --off|-o
   Turn off all LEDs.

 --verbose|-v
   Show LEDs being turned on/off.

 --help|-h
   This help.
 "
  exit 1
}
### HELP ENDS ###

if ! [ "$#" -gt 0 ]; then usage; fi

### VARIABLE INITIALIZATION STARTS ###
on=""
off=""
### VARIABLE INITIALIZATION ENDS ###

### ARGUMENT PROCESSING STARTS ###
while true ; do
  case $1 in
    --help|-h)
      usage
      ;;
    ++red|+r)
      on="$on red"
      shift 0
      ;;
    --red|-r)
      off="$off red"
      shift 0
      ;;
    ++green|+g)
      on="$on green"
      shift 0
      ;;
    --green|-g)
      off="$off green"
      shift 0
      ;;
    ++blue|+b)
      on="$on blue"
      shift 0
      ;;
    --blue|-b)
      off="$off blue"
      shift 0
      ;;
    ++cyan|+c)
      on="$on green blue"
      shift 0
      ;;
    --cyan|-c)
      off="$off green blue"
      shift 0
      ;;
    ++magenta|+m)
      on="$on red blue"
      shift 0
      ;;
    --magenta|-m)
      off="$off red blue"
      shift 0
      ;;
    ++yellow|+y)
      on="$on red green"
      shift 0
      ;;
    --yellow|-y)
      off="$off red green"
      shift 0
      ;;
    ++white|+w)
      on="$on red green blue"
      shift 0
      ;;
    --white|-w)
      off="$off red green blue"
      shift 0
      ;;
    --off|-o)
      on=""
      off="red green blue"
      shift 0
      ;;
    --verbose|-v)
      verbose=true
      shift 0
      ;;
    --*|-*)
      echo "ERROR:  invalid syntax. Use -h for help."
      exit 2
      ;;
    *)
      break
  esac
  shift
done
### ARGUMENT PROCESSING ENDS ###

### LEDS OFF STARTS ###
if [ "${verbose}" -a "${off}" != "" ] ; then echo "turning off LEDs:${off}"; fi

for led in $off; do
  if [[ "${verbose}" ]]; then echo "turning off ${led} LED"; fi
  if ! [ -f /sys/class/leds/${led}:status/hw_pattern ]; then echo pattern > /sys/class/leds/${led}:status/trigger; fi
  echo 0 5660 > /sys/class/leds/${led}:status/hw_pattern
  echo 255 > /sys/class/leds/${led}:status/repeat
  if [[ "${verbose}" ]]; then echo "${led} LED should be off now"; fi
done
### LEDS OFF ENDS ###

### LEDS ON STARTS ###
if [ "${verbose}" -a "${on}" != "" ]; then echo "turning on LEDs:${on}"; fi

for led in $on; do
  if [[ "$verbose" ]]; then echo "turning on ${led} LED"; fi
  if ! [ -f /sys/class/leds/${led}:status/hw_pattern ]; then echo pattern > /sys/class/leds/${led}:status/trigger; fi
  echo 255 > /sys/class/leds/${led}:status/brightness
  echo 255 5653 > /sys/class/leds/${led}:status/hw_pattern
  sleep 0.007s
  echo 255 > /sys/class/leds/${led}:status/repeat
  if [[ "$verbose" ]]; then echo "${led} LED should be on now"; fi
done
### LEDS ON ENDS ###
