////////////////////////////////////////////////////////////////////////////
// hyperOrganizer v1.1 // created 2016.10.17 // updated 2016.10.18
// designed by Matt Manhattan Russell // mattmanhattan.com // @futur3gentleman
////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////
// Share your designs on Instagram & Twitter with #hyperorganizer !!!
////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////
// D I M E N T I O N S  &  P A R T  O P T I O N S //////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////

parttype = "R"; // R = Rectangular / C = Circular

// PART DIMENSIONS & PEG PLACEMENT

width = 40; // Rectangular = Width / Circular = Diameter 
depth = 40; // Rectangular = Depth / Circular = MUST EQUAL WIDTH
height = 58; // This is the height of the shelf -- MINIMUM is '32' for 2 rows of pegs / 58
thickness = 1.6; // This is the thickness of the shelf (1.6 = good / 2.0 better / > 2.0 = very durable)
pegs = 1; // span between pegs [0 = centered (one peg // 1 = 2 pegs // 2 = 3 pegs // 3 = 4 pegs]
rows = 2; // span between pegs [0 = one row (one peg // 1 = 2 rows // 2 = 3 rows // 3 = 4 rows]


// Optimal (Rounded) size for peg widths = 31.75 (32) / 57.15 (58) / 82.85 (83) // [+25.4]

// ADVANCED PART OPTIONS

solid = "N"; // "Y" = yes / "N" = no (this is great for when you want to cut away parts of the solid base)
base = "Y" ; // "Y" = yes / "N" = no (good for when you want a mount)
offset = 0; 

// ANGULAR CUTAWAY OPTIONS

subtractangle = "N"; // "Y" = yes / "N" = no 
subtractpercent = -.6; // (see below for percentage chart)

//  1.0 = 100% 
//  0.8 = 90% /  0.6 = 80% /  0.5 = 75% / 
//  0.4 = 70% /  0.2 = 60% /  0.0 = 50% / 
// -0.2 = 40% / -0.4 = 30% / -0.5 = 25% / 
// -0.6 = 20% / -0.8 = 10% / -1.0 = 0%

// PEG OPTIONS

pegDiameter = 6.35;     // 1/4 inch peg holes
pegLength = 4;          // length of the pegs
peg2peg = 12.7; // This number x 2 = distance between pegs (12.7 = 25.40 mm = 1/4 inch pegboard)
pegFitpercentage = 3;   // Creates a sphere at the end of the peg to 'grab' the pegboard. 0% adds nothing. 3% is what I keep for my pegboards. If they are not staying on increase this number for a tighter fit.
removepegs = "N" ; // "Y" = yes / "N" = no (if for some reason you wanted to remove the pegs)
morepegs = "N" ; // "Y" = yes / "N" = no

//////////////////////////////////////////////////////////////////////////////////////////////
// C O D E  B L O C K •  C O D E  B L O C K •  C O D E  B L O C K • //////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////

if (parttype == "R")            // will choose between rectangle or triangle and run that code
{
    rectangleselector();
}
else
{
    circleselector();
}

if ( removepegs == "N" )        // will add or remove pegs
{
    pegboardpegs();
}
else
{}

if ( morepegs == "Y" )          // will add or remove more pegs
{
    morepegsH();
}
else
{}

// ALL OF THE REAL CODE IS WITHIN THE BELOW MODULES! It ain't pretty but it works!

//////////////////////////////////////////////////////////////////////////////////////////////
//// [RECTANGLE SELECTOR] ////////////////////////////////////////////////////////////////////
//// You are using this as a hack to select between two options because you are a noob ///////

module rectangleselector()
{
if (subtractangle == "Y")
{
    difference()
    {
        makerectangle();
        angularsubtraction();
    }
}
else
{
    makerectangle();
}
}

//////////////////////////////////////////////////////////////////////////////////////////////
//// [CIRCLE SELECTOR] ///////////////////////////////////////////////////////////////////////
//// You are using this as a hack to select between two options because you are a noob ///////

module circleselector()
{
    if (subtractangle == "Y")
        {
            difference()
            {
            makecircle();
            angularsubtraction();
            }
        }
    else
        {
            makecircle();
        }
}

////////////////////////////////////////////////////////////////////////////////////////////
//// [MAKE RECTANGLE] //////////////////////////////////////////////////////////////////////
//// This module generates your rectangle based off the user selected options /////////////////

module makerectangle()
{
    if ( solid == "Y" )
    {
        rectangularexterior();
    }
    else
    {
    difference()
    {
        rectangularexterior();
        rectangularinterior();
    }
}

if ( base == "Y" )
{
    rectangularbase();
}
else
{}
}

////////////////////////////////////////////////////////////////////////////////////////////
//// [RECTANGULAR INTERIOR] ////////////////////////////////////////////////////////////////
//// This module creates the interior space of a rectangular bin ///////////////////////////

module rectangularinterior()
{
    translate([-(offset),0,0])
    {
    cube ([depth, width, height], true);
    }
}


////////////////////////////////////////////////////////////////////////////////////////////
//// [RECTANGULAR EXTERIOR] ////////////////////////////////////////////////////////////////
//// This module creates the exterior space of a rectangular bin ///////////////////////////

module rectangularexterior()
{
    translate([-(offset/2),0,0])
    {
        cube ([((depth+(thickness*2))+offset), (width+(thickness*2)), height], true);
    }
}

////////////////////////////////////////////////////////////////////////////////////////////
//// [RECTANGULAR BASE] ////////////////////////////////////////////////////////////////////
//// This module creates the base of a rectangular bin /////////////////////////////////////

module rectangularbase()
{ 
    translate([-(offset/2),0,-(height/2)])
        {
        cube([(depth+(thickness*2))+offset,width+(thickness*2),thickness], true);
        }
}
////////////////////////////////////////////////////////////////////////////////////////////
//// [MAKE CIRCLE] /////////////////////////////////////////////////////////////////////////
//// This module generates your circle based off the user selected options /////////////////

module makecircle()
{
if ( solid == "Y" )
{
   circularexterior();
}
else
{
difference()
    {
        circularexterior();
        circularinterior();
    }
}

if ( base == "Y" )
{
    circularbase();
}
else
{}
}


////////////////////////////////////////////////////////////////////////////////////////////
//// [CIRCULAR INTERIOR] ///////////////////////////////////////////////////////////////
//// This module creates a circular bin //////////////////////////////////////////////////////

module circularinterior()
{
translate([-(offset),0,.1])
{
cylinder(h=height+.1, r=width/2, center=true, $fn=300);
}
}

////////////////////////////////////////////////////////////////////////////////////////////
//// [CIRCULAR EXTERIOR] ////////////////////////////////////////////////////////////////
//// This module creates the exterior space of a rectangular bin ///////////////////////////

module circularexterior()
{
    translate([-(offset),0,0])
    {
        cylinder(h=height, r=((width+thickness+thickness)/2), center=true, $fn=300);
    }
    //translate([width/4,0,-(thickness/16)])
    translate([((width/4)-(offset/2)),0,0])
    {
        cube ([(width/2)+thickness+thickness+offset, width+thickness+thickness, (height)], true);
    }
}

////////////////////////////////////////////////////////////////////////////////////////////
//// [CIRCULAR BASE] ////////////////////////////////////////////////////////////////////
//// This module creates the base of a rectangular bin /////////////////////////////////////

module circularbase()
{ 
    translate([-(offset),0,(0-(height/2))])
        {
        cylinder(h=thickness, r=((width+thickness+thickness)/2), center=true, $fn=300);
        }
        
     translate([((width/4)-(offset/2)),0,-(height/2)])
        {
        cube([(width/2)+thickness+thickness+offset,width+(thickness*2),thickness], true);
        }
}


////////////////////////////////////////////////////////////////////////////////////////////
//// [PEGBOARD PEG - SINGLE] ///////////////////////////////////////////////////////////////
//// This module creates a single peg //////////////////////////////////////////////////////

module pegboardpeg()
{
    rotate([0,90,0])
    {
        cylinder(h=pegLength, r=(pegDiameter/2), $fn=30);
    }
    translate([pegLength,0,0])
    {
        sphere(d=(pegDiameter*(1+(pegFitpercentage/100))), $fn=30);
    }
}
////////////////////////////////////////////////////////////////////////////////////////////
//// [PEGBOARD PEGS - FOUR PEGS] ///////////////////////////////////////////////////////////
//// This module generates four pegs and moves them to ROWS & PEGS /////////////////////////

module pegboardpegs()
{
    //top right peg
translate([((depth+(thickness*2))/2),(peg2peg*pegs),(peg2peg*rows)])
    {
    pegboardpeg();
    }   
    
//top left peg    
translate([((depth+(thickness*2))/2),-(peg2peg*pegs),(peg2peg*rows)])
    {
    pegboardpeg();
    }  
 
//bottom right peg
translate([((depth+(thickness*2))/2),(peg2peg*pegs),-(peg2peg*rows)])
    {
    pegboardpeg();
    }       
    
//bottom left peg   
translate([((depth+(thickness*2))/2),-(peg2peg*pegs),-(peg2peg*rows)])
    {
    pegboardpeg();
    }   
}

////////////////////////////////////////////////////////////////////////////////////////////
//// [PEGBOARD PEGS - MORE PEGS ] //////////////////////////////////////////////////////////
//// This module generates four MORE pegs and adds them on the horizontal //////////////////

module morepegsH()
{
    //top right peg
translate([((depth+thickness)/2),(peg2peg*(pegs-2)),(peg2peg*rows)])
    {
    pegboardpeg();
    }   
    
//top left peg    
translate([((depth+thickness)/2),-(peg2peg*(pegs-2)),(peg2peg*rows)])
    {
    pegboardpeg();
    }  
 
//bottom right peg
translate([((depth+thickness)/2),(peg2peg*(pegs-2)),-(peg2peg*rows)])
    {
    pegboardpeg();
    }       
    
//bottom left peg   
translate([((depth+thickness)/2),-(peg2peg*(pegs-2)),-(peg2peg*rows)])
    {
    pegboardpeg();
    }   
}

////////////////////////////////////////////////////////////////////////////////////////////
//// [ANGULAR SUBTRACTION] /////////////////////////////////////////////////////////////////
//// This module removes part of your piece at a diagonal //////////////////////////////////

module angularsubtraction()
{
    translate([-offset,0,0])
    {

polyhedron
    (points = [
           [(0-((depth+thickness+thickness)/2)), 0-((width+thickness+thickness)/2), (height+thickness+thickness)/2],        // point 0
           [(0-((depth+thickness+thickness)/2)), (width+thickness+thickness)/2, (height+thickness+thickness)/2],            // point 1
           [(0-((depth+thickness+thickness)/2)), (width+thickness+thickness)/2, 0-(((height+thickness+thickness)/2)*subtractpercent)],      // point 2
           [(0-((depth+thickness+thickness)/2)), 0-((width+thickness+thickness)/2), 0-(((height+thickness+thickness)/2)*subtractpercent)],    // point 3
           [(depth+thickness+thickness)/2, 0-((width+thickness+thickness)/2), (height+thickness+thickness)/2],                                  // point 4
           [(depth+thickness+thickness)/2, (width+thickness+thickness)/2, (height+thickness+thickness)/2],                  // point 5
	       ], 
     faces = [
           [0,1,5],[0,5,4],          // top of triangle
           [0,4,3],                  // triangle on x-axis
           [5,1,2],                  // opposite triangle
           [1,0,2],[0,3,2],          // rear of triangle on y-axis
           [3,4,2],[5,2,4],          // angle of triangle
		  ]
     );
}
}

////////////////////////////////////////////////////////////////////////////////////////////
// That's all folks!