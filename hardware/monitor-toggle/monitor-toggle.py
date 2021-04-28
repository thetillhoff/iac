import RPi.GPIO as GPIO
from time import sleep

GPIO.setmode(GPIO.BCM) # GPIO numbering, not pin-numbering
outputIO = 15

GPIO.setup(outputIO, GPIO.OUT) # set GPIO as output

# Not sure why, but reversign the on/off sequence made it work...

GPIO.output(outputIO, GPIO.LOW)
#print("GPIO disabled")
sleep(1) # wait 1 second
GPIO.output(outputIO, GPIO.HIGH)
#print("GPIO ensabled")

GPIO.cleanup() # release the GPIO pins used in this program
