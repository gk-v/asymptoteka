struct RadarPlot{
  real[] data;
  string[] Legend;
  pen[] Pens;
  pen gridPen;
  pen axisPen;
  pen labelPen;
  pen legendPen;
  int n,m;
  real pieAngle;
  int maxX;
  int maxY;
  real step;
  real Step;
  pair O=(0,0);

  void drawSectors(){
    guide g;
    for(int i=0;i<n;++i){
      g=arc(0,data[i],i*pieAngle,(i+1)*pieAngle);
      fill(O--g--cycle,Pens[i%m]);
    }
  }   

  void drawGrid(){
    for(int i=1;i<=(int)(maxY/step);++i){
      draw(circle(O,i*step),gridPen);
    }
    for(int i=0;i<maxX;++i){
      draw(rotate(i*360/maxX)*(O--(maxY,0)),gridPen);
    }
  }

  void drawAxes(){
    draw((-maxY,0)--(maxY,0),axisPen);
    draw((0,-maxY)--(0,maxY),axisPen);
  }

  void drawLabels(){
    for(int i=1;i<=(int)(maxY/Step);++i){
      draw(Label(string(i*Step),(0,i*Step)),roundbox,filltype=UnFill,labelPen);
      draw(Label(string(i*Step),(0,-i*Step)),roundbox,filltype=UnFill,labelPen);
      draw(Label(string(i*Step),(-i*Step,0)),roundbox,filltype=UnFill,labelPen);
      draw(Label(string(i*Step),(i*Step,0)),roundbox,filltype=UnFill,labelPen);
    }
  }

  void drawLegend(){
    transform t;
    real a;
    pair v;
    for(int i=0;i<n;++i){
      a=(i+0.5)*pieAngle;
      t=rotate(a);
      v=t*(data[i],0);
      if(a<90 || a>270){
        label(t*Legend[i],v,unit(v),legendPen);
      }else{
        label(rotate(a-180)*Legend[i],v,unit(v),legendPen);        
      }
      
    }
  }

  void draw(){
    drawGrid();
    drawSectors();
    drawAxes();
    drawLabels();
    drawLegend();
  }  
  
  void putText(string s, real x, real y, pair pos=O, pen p=currentpen){
    label(s,rotate(x*pieAngle)*(y,0),pos,p);
  }
  
  void operator init(real[] data, string[] Legend, pen[] Pens
    ,int maxX=2data.length
    ,int maxY=(int)max(data)+1
    ,pen gridPen=rgb(0.812,0.8,0.776)
    ,pen axisPen=darkblue
    ,pen labelPen=deepblue
    ,pen legendPen=deepgreen
    ,real step=1
    ,real Step=2step
  ){
    this.data=copy(data);
    this.Pens=copy(Pens);
    this.Legend=copy(Legend);

    this.n=data.length;
    this.m=Pens.length;
    this.pieAngle=360/n;
    this.maxX=maxX;
    this.maxY=maxY;
    this.gridPen=gridPen;
    this.axisPen=axisPen;
    this.labelPen=labelPen;
    this.legendPen=legendPen;
    this.step=step;
    this.Step=Step;
  }
};
