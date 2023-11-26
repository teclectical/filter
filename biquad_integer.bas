x=0
dim integer y
dim integer init_val
dim integer kf
init_val=20
kf=0
y=biquad(50,0)


dim yn
dim a,b,r
r = 1
b = r*(-1)
a=2 * r * COS(400)
dim yAn1=a*8
dim yAn2=0
rem a=-0.9, yn1=0, yn2=a*8
rem -0.9 und -1.1 geht -1 nicht
a=-.95
rem yan1 macht die Amplitude1
rem a macht die Frequenz innrhalb z.B. 1.05
yAn1=-42
yAn2=0

init_val =0
kf = 100
do
  y=biquad(0,20 )



  for i=0 to 2
  yAn= (a*yAn1)-yAn2
  yAn2=yAn1
  yAn1=yAn
  next

  #print x,y
   
  pixel x, 600-(yAn*2)
  pixel x, 200-(y)  
  pause 20
  if x < 1020 then 
    x= x + 1
  endif
  if x >= 1019 then 
    page scroll 0 , -1 ,0
    line 1023,0,1023,767,2, RGB(black)
  endif

loop

function biquad (init_val,  kf)
  static integer sin_del
  #print sin_del
  static integer cos_del
  if init_val > 0 then
    cos_del = (init_val<<8)
    sin_del=0
  endif

  tmp=sin_del*kf
  #print tmp
  text 0,20, BIN$(tmp)
  text 0,40, BIN$(tmp>>>8)
  text 0,60, BIN$(tmp/256)
  
  tmp=tmp>>>8  
  cos_del=cos_del-tmp
  tmp=cos_del*kf
  tmp=tmp>>>8
  sin_del=sin_del+tmp
  
  #do
  #loop until keydown(1)=99 
  #text 0,20, "                                             "
  #text 0,40, "                                             "
  #text 0,60, "                                             "
  #text 0,80, "                                             "
  


  #pause 200



  biquad = sin_del/256
end function




