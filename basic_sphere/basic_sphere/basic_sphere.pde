import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;
import peasy.test.*;

PeasyCam cam;

void setup(){
    size(600,600, P3D);
    cam = new PeasyCam(this, 500);
    noLoop();
}

void draw(){
  background(0);
  fill(255);
  
  for(int r =0; r < 10; r++){
    pushMatrix();
      int radius = int(random(50,200));
      translate(random(0+radius, width-radius)-width/2, random(0+radius, height-radius)-height/2);
      // sphere(200);  
      int total = radius;
      
      for(int i = 0; i < total; i++){
        float lon = map(i, 0, total, -PI, PI);
        for(int j = 0; j < total; j++){
          float lat = map(j, 0, total, -PI, PI);
          
          float x = radius*sin(lon)*cos(lat);
          float y = radius*sin(lon)*sin(lat);
          float z = radius*cos(lon);
          
          stroke(255);
          point(x,y,z);
          
        }
      }
    popMatrix();
  } 
}