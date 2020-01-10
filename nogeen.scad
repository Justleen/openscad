$fn=50;

wall=2;
rad=5.2;
dikte=1;
lengte=25;
breedte=10;

module outline_ext(w=1) {
  difference() {
    offset(w) children();
    offset(0) children();
  }
}

module outline(w=1) {
    offset(w/ 2) children();
}

*color("blue") linear_extrude(height=5+dikte){
  outline_ext(w=wall) circle(rad);
  translate([-rad,-rad/2-1,0]) square([2,rad+2]);
}

//bodem schroefgat
*linear_extrude(dikte) outline_ext(w=rad) circle(2);


// onderplaat
*translate([breedte/2,0,0]) square([lengte,breedte], center=true);

 *for (a=[0:5]) 
  translate([breedte/2,a*20,0]) linear_extrude(dikte) square([lengte,breedte], center=true);

* for (i=[0:15:360])
  rotate([i,90,0])
    translate([0,10,0])
     outline(w=1)  square(10);

for (i=[0:5:15])
  translate([0,0,i-5])
    cylinder(d=i,h=5);