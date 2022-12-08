class LineSegment {
  PVector start, end;
  
  LineSegment(PVector start, PVector end){
    this.start = start;
    this.end = end;
  }
  
  LineSegment[] split(){
    LineSegment[] segments = new LineSegment[4];
    PVector startToEnd = end.copy().sub(start);
    PVector endToStart = start.copy().sub(end);
    segments[0] = new LineSegment(start, startToEnd.copy().div(3).add(start));
    segments[1] = new LineSegment(endToStart.copy().div(3).add(end), end);
    
    segments[2] = new LineSegment(startToEnd.copy().div(3).add(start), 
      startToEnd.copy().div(3).add(start).add(startToEnd.copy().div(3).rotate(PI+TWO_PI / 3)) //endToStart.div(3).add(endToStart.copy().div(3).rotate(TWO_PI / 3))
      );
    segments[3] = new LineSegment( 
      endToStart.copy().div(3).add(end).add(startToEnd.copy().div(3).rotate(-TWO_PI / 3)) //startToEnd.div(3).add(startToEnd.copy().div(3).rotate(TWO_PI / 3))
      , endToStart.copy().div(3).add(end));
    return segments;
  }
  
  void draw(float size, PVector offset){
    stroke(255);
    strokeWeight(2);
    line((start.x - offset.x) * size + offset.x, (start.y - offset.y) * size + offset.y, 
      (end.x - offset.x) * size + offset.x, (end.y - offset.y) * size + offset.y);
  }
}
