

rem a=-0.9, yn1=0, yn2=a*8
rem -0.9 und -1.1 geht -1 nicht
a=1.99*10
rem yan1 macht die Amplitude1
rem a macht die Frequenz innrhalb z.B. 1.05
dim integer yAn1=4*10
dim integer yAn2=0
x=0

do
  yAn=biquad2(a, x, yAn1, yAn2)

  pixel x, 600-(yAn>>>4)
  pixel x, 200-(y)  
  pause 1

  if x < 1020 then 
    x= x + 1
  endif
  if x >= 1019 then 
    page scroll 0 , -1 ,0
    line 1023,0,1023,767,2, RGB(black)
  endif
loop


function biquad2 (a, x, init1, init2)  
  static integer yn
  static integer yn2, Yn1
  if x = 0 then
    yn1 = init1
    yn2 = init2
  End if
  yn= (19.90*yn1)- (10*yn2)
  yn2=yn1*10
  yn1=yn
  biquad2=yn
end function
