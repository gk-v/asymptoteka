// Area of a closed shape w/o self-intersections

real intxdydt0_1(guide cubicsegment, bool ydx=false){ 
  // int(x(t)*y'(t)dt,t=0..1) if ydx=false,
  // int(y(t)*x'(t)dt,t=0..1) if ydx=true,
  pair a,b,c,d;
  a=point(cubicsegment,0);  
  b=postcontrol(cubicsegment,0);
  c=precontrol(cubicsegment,1);
  d=point(cubicsegment,1);
  if(ydx){
    a=(a.y,a.x);
    b=(b.y,b.x);
    c=(c.y,c.x);
    d=(d.y,d.x);
  }
  return (
       (d.y+3*(c.y+2*b.y)-10*a.y)*a.x
       +3*(c.y+d.y-2*a.y)*b.x
       -3*(b.y+a.y-2*d.y)*c.x
       -(a.y+3*(b.y+2*c.y)-10*d.y)*d.x
       )/20;
}

real area(guide[] g){
  real s;
  for(int i=0;i<g.length;++i){
    s+=intxdydt0_1(g[i])-intxdydt0_1(g[i],ydx=true);
  }
  return abs(s/2);
}

real area(guide q){
  real s;
  guide g;
  assert(cyclic(q),"The curve is not closed. ");
  for(int i=0;i<size(q);++i){
    g=subpath(q,i,i+1);
    s+=intxdydt0_1(g)-intxdydt0_1(g,ydx=true);
  }
  return abs(s/2);
}
