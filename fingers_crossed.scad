include <cyl_head_bolt.scad>;

$fn = 50;
lengte=25;
breedte=7;
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
      translate ([0,breedte/2,dikte-1]) 
        cylinder(d=10.4,h=20);
    }
  }

  module schoefgat() {
    linear_extrude(height=dikte+5) {
      translate ([-5.5,-2,0])  square([1,8]);
      color("blue")
        translate ([0,breedte/2,0])  
          outline() circle(d=outerD);
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
    translate([16,10,23+dikte])
      rotate([90,0,0])
        cylinder(r=20,h=20, $fn=100);
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
    translate([-4,-5,0])
      union() {
        cube([10,50-dikte, dikte+1]);
        translate([10,0,0])
          cube([2,50-dikte, dikte+4]);
      }
    translate([1, 0, 50+e]) hole_through(name="M4", l=50+5, cld=0.1, h=10, hcld=0.4);
    translate([1, 0, 2]) hole_through(name="M4", l=55, cld=0.1, h=10, hcld=0.4);

    translate([1, 35,  50+e]) hole_through("M4",  l=50+5, cld=0.1, h=10, hcld=0.4);
    translate([1,35, 2]) hole_through(name="M4", l=55, cld=0.1, h=10, hcld=0.4);
  }
}


translate([0,breedte/2,0]) {
  x=13;
    linear_extrude(height=dikte)  triBrace(x);
    translate([lengte,-x-4 , 7]) rotate([0,90,0]) sqBrace(x=20); 
}


module houder() {
  d=4;
  h=50;
  difference() {
    union() {
      translate([-5,-5,0]) 
        cube([10,50-d, d+1]);
      translate([0,-8,h/2+d+1])
        rotate([-90,0,0]) 
          difference() {
            cylinder(d=h+d,h=h);
            translate([0,0,d]) 
              cylinder(d=h,h=h+d);
            for (z=[0:18:360]) {
              rotate([0,0,z])
                translate([0,20,25])
                  rotate([0,90,0]) 
                    cube([40,14,5], center=true);
            }
          }
    }
    translate([0, 0, 50+e]) hole_through(name="M4", l=50+5, cld=0.1, h=10, hcld=0.4);
    translate([0, 35,  50+e]) hole_through("M4",  l=50, cld=0.1, h=10, hcld=0.4);
    translate([0, 00,  50+e]) nutcatch_parallel("M4", l=50);
    translate([0, 35,  50+e]) nutcatch_parallel("M4", l=50);
  }

}

*translate([lengte+3,-dikte-9,dikte]) rotate([90,0,0]) houder();

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
