module holes() {
  for (step=[0:5:hoogte-10]) {
    translate([0,0,5+step]) rotate ([step,90,0]) cylinder(h=60,d=4,center=true);
  }
}


difference() {
  cylinder(d=hoogte+dikte,h=hoogte);
  translate([0,0,dikte]) cylinder(d=hoogte,h=hoogte+dikte);
  union(){
  for (rads=[0:18:360]) {
    rotate ([0,0,rads]) holes();
  }
  }

}


module cutout(x) {
  translate([lengte+2,x,dikte/2]) rotate([90,0,0]) cylinder(h=2*x,d=dikte-2.8, $fn=3);
}

module struts() {
  for (a=[-30:3:30]) {
    translate([lengte+1.6,a,0]) cylinder(h=dikte-1,r=0.2);
  }
}
