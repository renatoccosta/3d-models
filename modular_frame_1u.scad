// PARAMETERS ======================
$fn=50;

_1u = 44;
thikness = 3;
frameHeight = _1u;
frameWidth = 140;

offset = 1;

M3 = 3;
// =================================

mainFrame();
lateralHolders();
bulkHeads();

module mainFrame() {
    difference() {
        cube([frameWidth, frameHeight, thikness]);

        slotWidth = _1u * 3;
        maxSlots = floor(frameWidth / slotWidth);
        slotContainerWidth = frameWidth / maxSlots;    
        containerFreeSpace = slotContainerWidth - slotWidth;

        for(i=[0:maxSlots-1]) {
            translate([(i * slotContainerWidth) + (containerFreeSpace/2),0,0]) {
                slot(slotWidth);    
            }
        }
    }
}

module slot(slotWidth = 2*_1u, slotHeight = frameHeight) {
    holeOffset = 5.5;
    screwHoleRadius=M3/2;
    
    for (i = [1:3]) {
        translate([0,(slotHeight/4)*i,-offset/2]) {
            translate([holeOffset,0,0]) {
                screwHole(screwHoleRadius);
            }
            translate([slotWidth-holeOffset,0,0]) {
                screwHole(screwHoleRadius);
            }
        }   
    }
    
    marginLeft = 2 * holeOffset;
    marginBottom = 5;
    
    translate([marginLeft, marginBottom, -offset/2]) {
        cube([slotWidth - 2 * marginLeft, 
            slotHeight-(2*marginBottom),
            thikness+offset]);
    }
}

module lateralHolders() {
    holderWidth = 25;
    holderHeight = frameHeight-2;

    translate([thikness,(frameHeight-holderHeight)/2,thikness]) {
        holder(holderWidth, holderHeight);
    }
    translate([frameWidth,(frameHeight-holderHeight)/2,thikness]) {
        holder(holderWidth, holderHeight);
    }
}

module holder(width, height) {
    rotate([0,-90,0]) {
        difference() {
            cube([width, height, thikness]);
            for(i = [1:3]) {
                translate([(width/3)*2,(height/4)*i,-offset/2]) {
                    screwHole(M3/2);
                }
            }
        }
    }
}

module screwHole(screwHoleRadius=2.5) {
    holeOffset = 0.25;
    cylinder(h=thikness+offset, r=(screwHoleRadius + holeOffset));
}

module bulkHeads() {
    //Top and bottom bulkheads for better resistance
    bulkHeadWidth = frameWidth-20;

    translate([(frameWidth-bulkHeadWidth)/2,0,0]) {
        bulkhead(bulkHeadWidth, thikness);
        translate([0, frameHeight - thikness, 0]) {
            bulkhead(bulkHeadWidth, thikness);
        }
    }    
}

module bulkhead(width = frameWidth, thikness) {
    cube([width, thikness, thikness*4]);
}