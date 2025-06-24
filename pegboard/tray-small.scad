use <base.scad>

smooth = 50;
pegdiam = 5;
pegdepth = 2;
holespace = 25;
holespacediag = holespace+pegdiam*2;
d=sin(45)*holespacediag;
wall=3;

module pegboard(){
for ( i = [-2 : 2] ){
    for ( j = [-2 : 2] ){
color("BLUE"){
translate([0,i*holespace,j*holespace]){
//sphere([1,1,1]);
    
}
}
}

}
}
#pegboard();


module hook(){

translate([-0,0,pegdiam]){
difference(){
#rotate([90,0,0]){
rotate_extrude(convexity = 10, $fn = smooth)
translate([pegdiam, 0, 0])
circle(d = pegdiam, $fn = smooth);
}
translate([pegdiam,0,0]){
    cube([pegdiam*2,pegdiam,pegdiam*3], center=true);
}
translate([0,0,pegdiam]){
    cube([pegdiam*3,pegdiam,pegdiam*2], center=true);
}

}
translate([-pegdiam,0,0]){
#sphere(d=pegdiam,$fn = smooth);
}


}
}
module lowpeg(){
    
    translate([0,0,0]){
rotate([0,90,0]){
cylinder(d=pegdiam,h=pegdepth,$fn = smooth);
}
}

}
/*
translate([0,holespace,holespace]){
hook();
}

translate([0,-holespace,holespace]){
hook();
}

translate([0,0,holespace]){
hook();
}

translate([-pegdepth,0,0]){
lowpeg();
}

 
translate([-pegdepth,holespace,0]){
lowpeg();
}

translate([-pegdepth,-holespace,0]){
lowpeg();
}
*/

difference(){
hull() {
translate([0,-holespace-pegdiam,-pegdiam]){
cube([holespace,(holespace+pegdiam)*2,holespace+pegdiam*2]);
}

color("BLUE"){
translate([holespace*0.3,-holespace-pegdiam,holespace/2]){
rotate([0,45,0]){
cube([d,(holespace+pegdiam)*2,d]);
}
}
}
}

translate([wall,-holespace-pegdiam+wall,-pegdiam+wall]){
    cube([holespace-wall,((holespace+pegdiam)*2)-(wall*2),holespace+pegdiam*2]);
}
translate([(holespace)*0.3,-holespace-pegdiam+wall,(holespace/2)+wall]){
rotate([0,45,0]){
    cube([d,((holespace+pegdiam)*2)-(wall*2),d]);
}
}

translate([0,-holespace-pegdiam-2,holespace+pegdiam]){
    rotate([0,22.38,0]){
        cube([holespace*2,((holespace+pegdiam)*2)+3,holespace]);
}
}



}
//
//polyhedron(
//  points=[  [0,-holespace-pegdiam,holespace+pegdiam], //0
//            [0,holespace+pegdiam,holespace+pegdiam], //1
//            [holespace*2,holespace+pegdiam,holespace+pegdiam], //2
//            [holespace*2,-holespace-pegdiam,holespace+pegdiam], //3
//            [0,-holespace-pegdiam,-pegdiam], //4
//            [holespace,-holespace-pegdiam,-pegdiam], //5
//            [0,holespace+pegdiam,-pegdiam], //6
//            [holespace,holespace+pegdiam,-pegdiam] //7
//  ],                                 // the apex point 
//  faces=[ [0,1,2,3],
//          [0,3,5,4],
//          [1,2,7,6], 
//          [4,5,7,6], 
//          [4,5,7,6],
//          [2,3,5,7],
//          [0,1,6,4],
//
//]                  // two triangles for square base
// );



color("BLUE"){
translate([0,holespace+pegdiam,-pegdiam]){
//sphere([1,1,1]);
    
}
}

translate([.5,0,12.5]) rotate([0,90,0]) #pinHolder(2,2);

