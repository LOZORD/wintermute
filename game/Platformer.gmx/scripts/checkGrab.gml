/*
    Use within Player state jump and djump

*/

if (keyboard_check(ord('A'))){
    //grabbing left wall
    if (instance_exists(instance_place(x-HERO_GRAB_DIST,y,Wall))){
        vspeed = 0;
        hspeed = 0;
        state = STATE_GRAB;
    }
} else if (keyboard_check(ord('D'))){
    //grabbing left wall
    if (instance_exists(instance_place(x+HERO_GRAB_DIST,y,Wall))){
        vspeed = 0;
        hspeed = 0;
        state = STATE_GRAB;
    }
}
