#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright (C) 2024, Manuel Fombuena <fombuena@outlook.com>
#
# disco-test.sh - Shell script to test LEDs using leds_st1202.sh
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

s=0.2s

for i in $(seq 1 10); do
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
