
open "data.txt" for input as #1
line input #1, data$
beta=-0.75
x=0
filter1_delay=val(data$)
filter1_old=1
filter2_delay=0
filter5_old=1
a=0.3
rem filter1_old = (y(t-1)
rem filter1_delay = x(t)
rem filter1_new = y(t)

do
  line input #1, data$
  current = val(data$)
  rem tietze schenk
  filter1_new = (filter1_delay - (beta * filter1_old))*1
  filter1_old=filter1_new
  filter1_delay=current

  filter1_new = (current - (beta * filter1_old))*1
  filter1_old=filter1_new
  filter1_delay=current

  
  rem cms implementierung 2 x 3dB
  filter2_new = (filter2_delay* 0.5) + (current * 0.5) 
  filter2_delay = filter2_new
  filter3_new = (filter3_new* 0.5) + (filter2_delay * 0.5) 
  filter3_delay = filter2_new
  
  rem tietze schenk 2x
  filter4_new = (filter1_new - (beta * filter4_old))*0.3
  filter4_old = filter4_new

  rem stomp ardino  
  filter5= filter5_old + a* (current - filter5_old)
  filter5_old = filter5

  text 0,100, "Carsten 3dB "   
  pixel x, 130-(filter2_new*30)

  text 0,220, "Carsten 6dB "   
  pixel x, 250-(filter3_new*30)

  text 0,340, "Tietze 3dB"   
  pixel x, 370-(filter1_new*10)


  text 0,460, "Tietze 6dB"   
  pixel x, 490-(filter4_new*30)

 
  text 0,580, "Arduino Stomp"   
  pixel x, 610-(filter5*30)

  text 0,730, "Raw"   

  pixel x, 750-(current*30)
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

loop


