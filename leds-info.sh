#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright (C) 2025, Manuel Fombuena <fombuena@outlook.com>
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

sysfs="/sys/class/leds"

for sysled in $(ls $sysfs) ; do
  leds="$leds $sysled"
done

echo

for led in $leds; do
  echo Current settings for LED $led
  for setting in $(find ${sysfs}/${led}/ -maxdepth 1 -type f -exec basename {} \; | sort) ; do
    echo $setting: $(cat ${sysfs}/${led}/${setting})
  done
  echo
done
