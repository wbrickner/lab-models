global_fn = 128;
dh = 0.01;

// parameters
numberOfHoles = 12;
holeRadius = 3.5;
holeSeperation = 2;
lengthPadding = 10;
breadthPadding = 5;
interrowDistance = 25;
tubeHoldLedgeThickness = 2.25;
tubeHoldGapHeight = 15;
tubeHoldGapBreadth = 12;
bottomLedgeThickness = 2.5;
insetLengthPadding = 3;
insetThicknessPadding = 2.5;
insetDepth = 3.5;
borderRadius = 2.5;

// computed values
effectiveLength = 2*lengthPadding + (numberOfHoles * holeRadius * 2) + (numberOfHoles - 1)*holeSeperation;
effectiveBreadth = 2*holeRadius + 2*breadthPadding + interrowDistance;
effectiveThickness = tubeHoldLedgeThickness + tubeHoldGapHeight + bottomLedgeThickness;

echo(effectiveLength);

difference() {
    // main body
    union() {
        difference() {
            cube([effectiveLength, effectiveBreadth, effectiveThickness]);
            
            // cut out long thin cubes, to be replaced by rounded edges
            translate([0, 0, 0]) {
                cube([borderRadius, borderRadius, effectiveThickness]);
            }
            translate([effectiveLength - borderRadius, 0, 0]) {
                cube([borderRadius, borderRadius, effectiveThickness]);
            }
            translate([0, effectiveBreadth - borderRadius, 0]) {
                cube([borderRadius, borderRadius, effectiveThickness]);
            }
            translate([effectiveLength - borderRadius, effectiveBreadth - borderRadius, 0]) {
                cube([borderRadius, borderRadius, effectiveThickness]);
            }
        }
        
        // rounded edges
        translate([borderRadius, borderRadius, 0]) {
            cylinder(r = borderRadius, h = effectiveThickness, $fn=global_fn);
        }
        translate([effectiveLength - borderRadius, borderRadius, 0]) {
            cylinder(r = borderRadius, h = effectiveThickness, $fn=global_fn);
        }
        translate([borderRadius, effectiveBreadth - borderRadius, 0]) {
            cylinder(r = borderRadius, h = effectiveThickness, $fn=global_fn);
        }
        translate([effectiveLength - borderRadius, effectiveBreadth - borderRadius, 0]) {
            cylinder(r = borderRadius, h = effectiveThickness, $fn=global_fn);
        }
    }

    // top row
    for (j = [0:numberOfHoles - 1]) {
        translate([lengthPadding + holeRadius + j*(2*holeRadius + holeSeperation), breadthPadding + holeRadius + interrowDistance, bottomLedgeThickness]) {
            cylinder(r=holeRadius, h=100, $fn=global_fn);
        }
    }
    
    // bottom row
    for (j = [0:numberOfHoles - 1]) {
        translate([lengthPadding + holeRadius + j*(2*holeRadius + holeSeperation), breadthPadding + holeRadius, bottomLedgeThickness]) {
            cylinder(r=holeRadius, h=100, $fn=global_fn);
        }
    }
    
    // top row's gap
    translate([0, 0, bottomLedgeThickness]) {
        cube([effectiveLength, tubeHoldGapBreadth, tubeHoldGapHeight]);
    }
    
    // bottom row's gap
    translate([0, effectiveBreadth - tubeHoldGapBreadth, bottomLedgeThickness]) {
        cube([effectiveLength, tubeHoldGapBreadth, tubeHoldGapHeight]);
    }
    
    // top row's inset
    translate([insetLengthPadding, effectiveBreadth - tubeHoldGapBreadth - insetDepth, bottomLedgeThickness + 2*insetThicknessPadding]) {
        cube([effectiveLength - 2*insetLengthPadding, insetDepth, effectiveThickness - bottomLedgeThickness - tubeHoldLedgeThickness - 2*insetThicknessPadding]);
    }
    
    // bottom row's inset
    translate([insetLengthPadding, tubeHoldGapBreadth, bottomLedgeThickness + 2*insetThicknessPadding]) {
        cube([effectiveLength - 2*insetLengthPadding, insetDepth, effectiveThickness - bottomLedgeThickness - tubeHoldLedgeThickness - 2*insetThicknessPadding]);
    }
}