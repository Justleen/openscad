include <cyl_head_bolt.scad>;
$fn = 25;
dikte=4;
hoogte=50;

module sqBrace(x) {
  difference() {
    translate([-4,-5,0]) cube([8, x*3-10, dikte+1]);
    translate([0, 0, 50+e]) hole_through(name="M4", l=50+5, cld=0.1, h=10, hcld=0.4);
    translate([0, 0, 2]) hole_through(name="M5", l=55, cld=0.1, h=10, hcld=0.4);

    translate([0, x*3-20,  50+e]) hole_through("M4",  l=50+5, cld=0.1, h=10, hcld=0.4);
    translate([0, x*3-20, 2]) hole_through(name="M5", l=55, cld=0.1, h=10, hcld=0.4);
  }
}

module houder() {
  difference() {
    union() {
      translate([-5,-5,0]) 
        cube([10,50-dikte, dikte+1]);
      translate([0,-8,hoogte/2+dikte+1])
        rotate([-90,0,0]) 
          difference() {
            cylinder(d=hoogte+dikte,h=hoogte);
            translate([0,0,dikte]) cylinder(d=hoogte,h=hoogte+dikte);
          }
    }
    translate([0, 0, 50+e]) hole_through(name="M4", l=50+5, cld=0.1, h=10, hcld=0.4);
    translate([0, 35,  50+e]) hole_through("M4",  l=50, cld=0.1, h=10, hcld=0.4);
    translate([0, 00,  50+e]) nutcatch_parallel("M4", l=50);
    translate([0, 35,  50+e]) nutcatch_parallel("M4", l=50);
  }
}

houder();
*sqBrace(x=20);


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
