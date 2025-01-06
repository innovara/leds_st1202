#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright (C) 2024, Manuel Fombuena <fombuena@outlook.com>
#
# leds-info.sh - Shell script to show current LED settings.
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

for sysled in $(ls /sys/class/leds/) ; do
  leds="$leds $sysled"
done

echo

for led in $leds; do
  echo Current settings for $led
  echo trigger: $(cat /sys/class/leds/${led}/trigger)
  echo brightness: $(cat /sys/class/leds/${led}/brightness)
  if [ -f /sys/class/leds/${led}/hw_pattern ]; then echo hw_pattern: $(cat /sys/class/leds/${led}/hw_pattern); fi
  if [ -f /sys/class/leds/${led}/repeat ]; then echo repeat: $(cat /sys/class/leds/${led}/repeat); fi
  echo
done
