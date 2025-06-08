// corners wall thickness
wall=2;
// corners width
corner_side=4.1;
// mid ventilation bars thickness
mid_thickness=4;
// corners height
height=25;
// base thickness
base_thickness=3;
// distance between pi and ssd
distance_between=20;
// ssd width, samsung t7=57.1, standard=70.5
ssd_w=70.5;
// ssd height, samsung t7=8.05, standard=7.05
ssd_h=7.05;
// pi width
pi_w=56.3;
// pi height
pi_h=24.55;

$fn=$preview ? 20 : 100;

include <BOSL2/std.scad>
include <BOSL2/walls.scad>

module corners(w,l,h) {
  difference() {
    cube(size=[w+wall*2,l+wall*2,h]);
    translate([wall,wall,0]) cube(size=[w, l, h]);
    translate([0,corner_side+wall,0]) cube(size=[w + wall*2, l - corner_side*2, h]);
    translate([corner_side+wall,0,0]) cube(size=[w - corner_side*2, l + wall*2, h]);
  }
}

// BASE
base_w=min(ssd_w,pi_w)+wall*2;
base_l=ssd_h+pi_h+distance_between+wall*4;
sparse_wall(h=base_w, l=ssd_h+pi_h+distance_between+wall*4, thick=base_thickness, orient=RIGHT, anchor=BOTTOM);
translate([base_w/3-mid_thickness,-base_l/2,-base_thickness/2]) cube([mid_thickness,base_l,mid_thickness]);
translate([base_w*2/3,-base_l/2,-base_thickness/2]) cube([mid_thickness,base_l,mid_thickness]);

// SSD
ssd_overhang=(ssd_w-base_w+wall*2)/2;
translate([-ssd_overhang,(distance_between+pi_h-ssd_h)/2,-base_thickness/2]) {
    corners(w=ssd_w, l=ssd_h, h=height);
    if (ssd_w-base_w > wall*2) {
        cube([ssd_overhang+wall*2, ssd_h+wall*2, base_thickness]);
        translate([base_w+wall,0,0]) cube([ssd_overhang+wall*2, ssd_h+wall*2, base_thickness]);
    }
}

// PI
translate([0,-(distance_between+ssd_h+pi_h+wall*4)/2,-base_thickness/2]) corners(w=pi_w, l=pi_h, h=height);
