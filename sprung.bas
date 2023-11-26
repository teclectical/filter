
open "data.txt" for input as #1
line input #1, data$
beta=-0.35
x=0
filter1_delay=val(data$)
filter1_old=1
filter2_delay=0
filter5_old=1
a=0.3
do
  line input #1, data$
  current = val(data$)
  rem tietze schenk
  filter1_new = filter1_delay - (beta * filter1_old)
  filter1_old=filter1_new
  filter1_delay=current

  
 

  
  rem tietze schenk 2x
  filter4_new = (filter1_new - (beta * filter4_old))*0.65
  filter4_old = filter4_new


  #pixel x, 600-(filter2_new*20)
  pixel x, 400-(filter4_new*50)
  #pixel x, 400-(filter1_new*20)
  pixel x, 700-(current*50)
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


