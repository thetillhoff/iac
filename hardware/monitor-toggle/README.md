# monitor-toggle

> RPi only, as it uses GPIOs!

This script is used to toggle the power of the monitor attached to the RPi (for example the magic mirror).
A cable was soldered onto the control panel of the monitor - specifically to the power button on it - which is the inserted in GPIO15 (fifth pin top-left).
Executing the aforementioned script simulates pressing that button and therefore results in a power toggle of the monitor.

The main driver behind this was to use some kind of automation to power off the monitor when noone could see it and power it on when the opposite is the case.
