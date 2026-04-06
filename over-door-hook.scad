$fn = 64;

door_thickness = 8.5;
clearance = .8;

hook_width = 7;
wall = 5;

back_drop = 10;
front_drop = 50;

hook_reach = 25;
hook_tip_height = 15;

outer_depth = door_thickness + clearance + wall * 2;
r = wall / 2;

linear_extrude(hook_width)
    profile();

module profile() {
    union() {
        // Top section over the door.
        rounded_bar([r, 0], [outer_depth - r, 0], r);

        // Back tab that stays behind the door.
        rounded_bar([r, 0], [r, -back_drop], r);

        // Front leg.
        rounded_bar([outer_depth - r, 0], [outer_depth - r, -front_drop + r], r);

        // Rounded bottom of the outer hook.
        rounded_bar([outer_depth - r, -front_drop + r], [outer_depth + hook_reach - r, -front_drop + r], r);

        // Upturned outer tip.
        rounded_bar(
            [outer_depth + hook_reach - r, -front_drop + r],
            [outer_depth + hook_reach - r, -front_drop + hook_tip_height],
            r
        );
    }
}

module rounded_bar(start, end, radius) {
    hull() {
        translate(start) circle(r = radius);
        translate(end) circle(r = radius);
    }
}
