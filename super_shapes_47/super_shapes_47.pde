import peasy.*;
import controlP5.*;
import processing.dxf.*;

PMatrix3D currCameraMatrix;
PGraphics3D g3;
ControlP5 MyController;

PeasyCam cam;
PVector[][] globe;
int total = 75;
float m_1, n0_1, n1_1, n2_1;
float m_2, n0_2, n1_2, n2_2;

float a = 1;
float b = 1;

boolean saveDXF = false;

void setup(){
    size(1000,1000, P3D);
    cam = new PeasyCam(this, 500);
    globe = new PVector[total+1][total+1];
    colorMode(HSB);
    g3 = (PGraphics3D)g;
    MyController = new ControlP5(this);

    m_1 = 2; n0_1 = 0.7; n1_1 = 0.3; n2_1 = 0.2;
    m_2 = 3; n0_2 = 100; n1_2 = 100; n2_2 = 100;
    
    setupControllers();
 
    MyController.setAutoDraw(false);  
}

void gui() {
  currCameraMatrix = new PMatrix3D(g3.camera);
  camera();
  MyController.draw();
  g3.camera = currCameraMatrix;
}

void draw(){
  background(0);
   noStroke();
   lights();
   float radius = 200;
   
   if(saveDXF == true){
    beginRaw(DXF, "data/myCubes.dxf");
   }
      
   for(int i = 0; i < total+1; i++){
     float lat = map(i, 0, total, -HALF_PI, HALF_PI);
     for(int j = 0; j < total+1; j++){
      float lon = map(j, 0, total, -PI, PI);
      
      float r1 = supershape(lon,  m_1, n0_1, n1_1, n2_1);
      float r2 = supershape(lat, m_2, n0_2, n1_2, n2_2);
      
      float x = radius*r1*cos(lat)*r2*cos(lon);
      float y = radius*r1*sin(lon)*r2*cos(lat);
      float z = radius*r2*sin(lat);
      globe[i][j] = new PVector(x,y,z);
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
  
  if(saveDXF == true){
    endRaw();
    saveDXF = false;
  } 
  gui();
}


float supershape(float theta, float m, float n0, float n1, float n2) {
  float t1 = abs(cos(m * theta / 4.0)/a);
  t1 = pow(t1, n1);
  float t2 = abs(sin(m * theta/4.0)/b);
  t2 = pow(t2, n2);
  return pow(t1 + t2, -1.0 / n0);
}

void keyPressed(){
  if(key == 's'){
    saveDXF = true;
  }
}

void setupControllers(){
  
    MyController.addNumberbox("m_1").setPosition(50,10)
     .setSize(30,30)
     .setScrollSensitivity(1.1)
     .setValue(2);
     
    MyController.addNumberbox("n0_1").setPosition(100,10)
     .setSize(30,30)
     .setScrollSensitivity(0.1)
     .setValue(0.7);
     
    MyController.addNumberbox("n1_1").setPosition(150,10)
     .setSize(30,30)
     .setScrollSensitivity(0.1)
     .setValue(0.3);
     
    MyController.addNumberbox("n2_1").setPosition(200,10)
     .setSize(30,30)
     .setScrollSensitivity(0.1)
     .setValue(0.2);

    MyController.addNumberbox("m_2").setPosition(50,60)
     .setSize(30,30)
     .setScrollSensitivity(1.1)
     .setValue(3);
     
    MyController.addNumberbox("n0_2").setPosition(100,60)
     .setSize(30,30)
     .setScrollSensitivity(0.1)
     .setValue(100);
     
    MyController.addNumberbox("n1_2").setPosition(150,60)
     .setSize(30,30)
     .setScrollSensitivity(0.1)
     .setValue(100);
     
    MyController.addNumberbox("n2_2").setPosition(200,60)
     .setSize(30,30)
     .setScrollSensitivity(0.1)
     .setValue(100);
}