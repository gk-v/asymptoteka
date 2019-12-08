import graph;

// transforms a unitcircle to the ellipse
path ellipse(explicit pair f1, explicit pair f2, explicit pair pt){
  // f1, f2 - focii of the ellipse
  // pt is a point on the ellipse
  
  real a,b; // the major and minor semi-axes
  real cf;  // the dostance from the center to the focus

  a=arclength(f1--pt--f2)/2; 
  cf=arclength(f1--f2)/2;
  b=sqrt((a-cf)*(a+cf));
  
  pair c=(f1+f2)/2;
  real angle=atan2(f2.y-f1.y,f2.x-f1.x)/pi*180;
  
  path el=shift(c.x,c.y)*rotate(angle)*scale(a,b)*circle((0,0),1);
  return el;
}

path Ellipse(explicit pair f1, explicit pair f2, explicit pair pt){
  // f1, f2 - focii of the ellipse
  // pt is a point on the ellipse
  
  real a,b; // the major and minor semi-axes
  real cf;  // the dostance from the center to the focus

  a=arclength(f1--pt--f2)/2; 
  cf=arclength(f1--f2)/2;
  b=sqrt((a-cf)*(a+cf));
  
  pair c=(f1+f2)/2;
  real angle=atan2(f2.y-f1.y,f2.x-f1.x)/pi*180;
  
  path el=shift(c.x,c.y)*rotate(angle)*scale(a,b)*Circle((0,0),1);
  return el;
}

// Marden’s theorem
// https://en.wikipedia.org/wiki/Marden%27s_theorem
// In mathematics, Marden’s theorem, named after Morris Marden but proven much earlier by Jörg Siebeck,
// gives a geometric relationship between the zeros of a third-degree polynomial with complex coefficients and the
// zeros of its derivative.
// Suppose the zeroes z1 , z2, and z3 of a third-degree polynomial p(z) are non-collinear. There is a unique
// ellipse inscribed in the triangle with vertices z1 , z2 , z3 
// and tangent to the sides at their midpoints: 
// the Steiner inellipse. 
// The foci of that ellipse are the zeros of the derivative p0(z).

pair[] SteinerInellipseFoci(pair z1,pair z2,pair z3){
  pair p=z1+z2+z3;
  pair q=sqrt(z1^2+z2^2+z3^2-z1*z2-z2*z3-z3*z1);
  return new pair[]{(p+q)/3,(p-q)/3};
} 
 
pair SteinerInellipseAxes(pair z1,pair z2,pair z3){
  real a2=abs(z2-z3)^2, b2=abs(z1-z3)^2, c2=abs(z2-z1)^2;
  real q=sqrt(a2*(a2-b2)+b2*(b2-c2)+c2*(c2-a2));
  
  return (1/6*sqrt(a2+b2+c2+2*q),1/6*sqrt(a2+b2+c2-2*q));
}

// Generalization for $p(z)=(z-z_1)^u(z-z_1)^v(z-z_1)^w$
// , $u,v,w>0$:
// The foci of an ellipse 
// whose points of tangency to the triangle 
// divide its sides in the ratios $u : v$, $v : w$, 
// and $w : u$, with tangential points
//  
// \begin{align}
// \frac{w\,B+v\,C}{v+w}
// &
// ,\quad 
// \frac{u\,C+w\,A}{w+u}
// ,\quad 
// \frac{v\,A+u\,B}{u+v}
// .
// \end{align} 

pair[] SteinerInellipseFoci(pair z1, pair z2, pair z3, real u, real v,real w){
  real r=1/2/(u+v+w);
  pair p=(v+w)*z1+(w+u)*z2+(u+v)*z3; 
  pair q=sqrt(
    (v+w)^2*z1^2+(w+u)^2*z2^2+(u+v)^2*z3^2
    +2*( u*v-v*w-w*u-w^2)*z1*z2
    +2*(-u*v+v*w-w*u-u^2)*z2*z3
    +2*(-u*v-v*w+w*u-v^2)*z3*z1
  );
  return new pair[]{r*(p+q),r*(p-q)};
}

pair SteinerInellipseTanPoint(pair A, pair B, pair C, real u, real v,real w){
  return (w*B+v*C)/(w+v);
}

