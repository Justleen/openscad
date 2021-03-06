include <cyl_head_bolt.scad>;

$fn = 50;
lengte=20;
breedte=6;
hoogte=10;
dikte=5;
hole=4;
outerD=10.5;
wall = 2;
module outline() {
  difference() {
    offset(wall) children();
    offset(0) children();
  }
}

module base() {
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
      color("blue") translate ([0,breedte/2,0])  outline() circle(d=outerD);
    }
  }

  module stulp() {
     rotate([90,0,0]) { 
      linear_extrude (height=breedte) {
        square([9.5,5]);
      }
    }   
  }
  
  difference() {
    union(){
      translate([6.8,breedte,dikte]) stulp();
      schoefgat();
    }
    translate([16,10,23+dikte]) rotate([90,0,0]) cylinder(r=20,h=20, $fn=100);
  }
    onderkant();
}



color("blue") base();


module triBrace(x) {
    triangle_points =[[5,-5],[5,5],[lengte+2,x],[lengte+2,-x] , [8,-5],[8,5],[lengte,x-(x/3)],[lengte,-x+(x/3)]];
    triangle_paths =[[0,1,2,3] ,[4,5,6,7]];
    polygon(triangle_points,triangle_paths,10);
}

module sqBrace(x) {
  difference() {
    translate([-4,-5,0]) cube([8, x*3-10, dikte]);
    translate([0, 0, 50+e]) hole_through(name="M4", l=50+5, cld=0.1, h=10, hcld=0.4);
    translate([0, 0, 2]) hole_through(name="M5", l=55, cld=0.1, h=10, hcld=0.4);

    translate([0, x*3-20,  50+e]) hole_through("M4",  l=50+5, cld=0.1, h=10, hcld=0.4);
    translate([0, x*3-20, 2]) hole_through(name="M5", l=55, cld=0.1, h=10, hcld=0.4);
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

translate([0,breedte/2,0]) {
  x=15;
    linear_extrude(height=dikte)  triBrace(x);
    translate([lengte,-x-5 , 4]) rotate([0,90,0]) sqBrace(x=20); 
}




// == exaM4le nut catches and holes ==
    // rotate([180,0,0]) nutcatch_parallel("M4", l=5);

// echo(_get_screw("M4x8"));
// echo(_get_screw_fam("M5x8"));
// echo(_get_fam("M4"));
// difference() {
//   translate([-15, -15, 0]) cube([80, 30, 50]);
//   *rotate([180,0,0]) nutcatch_parallel("M5", l=5);
//   *translate([0, 0, 50+e]) hole_through(name="M5", l=50+5, cld=0.1, h=10, hcld=0.4);
//   *translate([55, 0, 9+e]) nutcatch_sidecut("M8", l=100, clk=0.1, clh=0.1, clsl=0.1);
//   *translate([55, 0, 50+e]) hole_through(name="M8", l=50+5, cld=0.1, h=10, hcld=0.4);
//   translate([27.5, 0, 50+e]) hole_threaded(name="M5", l=60);
// }
