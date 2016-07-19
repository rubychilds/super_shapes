import peasy.*;

PeasyCam cam;
PVector[][] globe;
int total = 200;

void setup(){
    size(600,600, P3D);
    cam = new PeasyCam(this, 500);
    globe = new PVector[total+1][total+1];
    colorMode(HSB);
}



void draw(){
  background(0);
   noStroke();
   lights();
      int radius = 200;
      // sphere(200);    
      
   for(int i = 0; i < total+1; i++){
     float lat = map(i, 0, total, 0, PI);
     for(int j = 0; j < total+1; j++){
      float lon = map(j, 0, total, 0, TWO_PI);
      float x = radius*sin(lat)*cos(lon);
      float y = radius*sin(lat)*sin(lon);
      float z = radius*cos(lat);
      globe[i][j] = new PVector(x,y,z);
      //point(x,y,z);
    }
   }

  for(int i = 0; i < total; i++){
    beginShape(TRIANGLE_STRIP);
    float hu = map(i, 0, total, 0, 255);
    fill(hu%255, 255, 255);
    for(int j = 0; j < total+1; j++){

      PVector v = globe[i][j];
      vertex(v.x, v.y, v.z);
      PVector v1 = globe[i+1][j];
      vertex(v1.x, v1.y, v1.z);
    }
    endShape();
  }
  
}