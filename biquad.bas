x=0


y=biquad(20,0)

#dim yn1=-4.5
#dim yn2=2.6
dim yn
dim a,b,r
r = 1
b = r*(-1)
a=2 * r * cos(400)
dim yn1=a*4
dim yn2=a/2

print a
do
  y=biquad(0,100 )
  for i=0 to 2
  yn= (a*yn1)+(b*yn2)
  yn2=yn1
  yn1=yn
  next

  #print x,y
   
  pixel x, 600-(yn*30)
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

function biquad (init_val, kf)
  static sin_del
  #print sin_del
  static cos_del
  if init_val > 0 then
    cos_del = (init_val<<8)
    sin_del=0
  endif

  tmp=sin_del*kf
  #print tmp
  #print BIN$(tmp)
  tmp=tmp/256  
  cos_del=cos_del-tmp
  tmp=cos_del*kf
  tmp=tmp/256
  sin_del=sin_del+tmp
  
  do
  loop until keydown(1)=99 
  text 0,20, BIN$(sin_del)
  text 0,40, STR$(sin_del)
  text 0,60, STR$(sin_del>>8)
  



  biquad = sin_del/256
end function




