$fn=50;


module outline(wall=1) {
  difference() {
    offset(wall) children();
    offset(0) children();
  }
}


color("blue") linear_extrude(height=5){
  rad=10.1;
  outline(wall=2) circle(rad);
  translate([-rad,-5,0]) square([1,10]);
}

outline(wall=8.2) circle(2);
