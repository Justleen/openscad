foot_height = 20;
$fn = 25;
lengte=18;
breedte=4;
hoogte=10;
dikte=2;
hole=4;
wall = 2;
module outline() {
  difference() {
    offset(wall) children();
    offset(0) children();
  }
}

module onderkant(radius=2) {
  difference() {
    linear_extrude(height = dikte) {
      difference() {
        union() {
          square([lengte,breedte]);
          translate([0,breedte/2,0]) circle(d=11);
        }
        translate ([0,breedte/2,0]) circle(d=hole);
      }
    }
    translate ([0,breedte/2,dikte-1]) cylinder(d=10.4,h=20);
  }
}

module schoefgat() {
  linear_extrude(height=dikte+5) {
    translate ([-5.5,-2,0])  square([1,8]);
    color("blue") translate ([0,breedte/2,0])  outline() circle(d=10.4);
  }
}

module stulp() {
  translate([6.8,breedte/2,2])
    rotate([90,0,0]) { 
      linear_extrude (height=2) {
        difference() {
          square(9.5);
          translate([10,22.3,0]) circle(20, $fn=100);
        }
      }
   }   
}

onderkant();
stulp();
schoefgat();
