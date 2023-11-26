#include "ina219.inc"
dim as integer confread(2)
dim as integer shuntvolt(2)
dim as integer vbusvolt(2)
dim as integer shuntcurrent(2)

i2c open 100, 100
i2c write ina219address, 0, 1, confregister
i2c read ina219address, 0, 2, confread()
LSB=confread(1)
HSB=confread(0)
HSB=HSB*256
register=HSB+LSB
#print BIN$(register,16)


i2c write ina219address, 0, 3, confregister, &b00111001, &b10011111

i2c write ina219address, 0, 1, confregister
i2c read ina219address, 0, 2, confread()
LSB=confread(1)
HSB=confread(0)
HSB=HSB*256
register=HSB+LSB
#print BIN$(register,16)

i2c write ina219address, 0, 3, calibrationregister, &b00010000, &b00000000
open "data2.txt" for OUTPUT as #1


x=0


do

  #strom
  spannung
  shunt
  pixel x, 700-(current*150)
  pause 50
  if x < 1020 then 
    x= x + 1
  endif
  if x >= 1019 then 
    text 0,00, "           "   
    text 0,20, "           "   
    text 0,40, "           "   
    page scroll 0 , -1 ,0
    line 1023,0,1023,767,2, RGB(black)
  endif
  if keydown(1) = 99 then
    close #1
  endif  
loop


rem not needed anymore
sub strom
  i2c write ina219address, 0, 1, currentregister
  i2c read ina219address, 0, 2, shuntcurrent()
  LSB=shuntcurrent(1)
  HSB=shuntcurrent(0)
  HSB=HSB*256
  current=HSB+LSB
  current=current*0.0001
  text 0,0, "Strom:" + STR$(current)  
  end sub

sub spannung
  i2c write ina219address, 0, 1, busvoltageregister
  i2c read ina219address, 0, 2, vbusvolt()
  LSB=vbusvolt(1)
  HSB=vbusvolt(0)
  HSB=HSB*256
  voltage=HSB+LSB
  #print BIN$(voltage,16)
  voltage = voltage>>3
  voltage = voltage * 0.004
  text 0,20, "VBus:" + STR$(voltage)  

end sub

sub shunt
  i2c write ina219address, 0, 1, shuntvoltageregister
  i2c read ina219address, 0, 2, shuntvolt()
  LSB=shuntvolt(1)
  HSB=shuntvolt(0)
  HSB=HSB*256
  volt=HSB+LSB
  volt=volt*0.00001*2
  current=volt*10
  text 0,40, "Shunt-Spannung:" + STR$(volt)  
  text 0,0, "Strom:" + STR$(current)  
  print #1, current
end sub

sub tiefpass
 filter = filter+1
end sub

 
