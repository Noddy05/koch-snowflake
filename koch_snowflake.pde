
ArrayList<LineSegment> segments = new ArrayList<LineSegment>();

void setup(){
  size(800, 800);
  segments.add(new LineSegment(new PVector(-100, 0), new PVector(100, 0)));
  segments.add(new LineSegment(new PVector(-100, 0).add(new PVector(200, 0).rotate(PI / 3)), new PVector(-100, 0)));
  segments.add(new LineSegment(new PVector(100, 0), new PVector(100, 0).add(new PVector(200, 0).rotate(PI - PI / 3))));
}

float size = -1;
void draw(){
  background(30);
  translate(width / 2 + offset.x, height / 2 + offset.y);
  for(LineSegment segment : segments){
    if(segment != null)
      segment.draw(size, offset);
  }
  
  if(mousePressed && mouseButton == RIGHT && newPosition){
    offset = new PVector(mouseX - mousePosition.x, mouseY - mousePosition.y);
  }
  if(!(mousePressed && mouseButton == RIGHT))
    newPosition = false;
}

PVector offset = new PVector(0, 50);

void mouseWheel(MouseEvent event){
  float e = event.getCount();
  size = min(size + e, -1);
}

boolean newPosition = false;
PVector mousePosition = new PVector();
void mousePressed(){
  if(mouseButton == RIGHT){
    mousePosition = new PVector(mouseX - offset.x, mouseY - offset.y);
    newPosition = true;
    return;
  }
  
  ArrayList<LineSegment> currentSegments = new ArrayList<LineSegment>();
  for(LineSegment segment : segments){
    if(segment != null)
      currentSegments.add(segment);
  }
  
  for(LineSegment segment : currentSegments){
    LineSegment[] newSegments = segment.split();
    for(int i = 0; i < 4; i++)
      segments.add(newSegments[i]);
    
    segments.remove(segment);
  }
}
