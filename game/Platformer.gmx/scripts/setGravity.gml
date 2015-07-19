/*
    Call within the Player step event


*/
if (state != STATE_GRAB){
    if (!place_free(x,y+vspeed)){
        gravity = 0;
        if (vspeed > 0) {
            move_contact_solid(270,vspeed);
        } else {
            move_contact_solid(90,vspeed);
        }
        vspeed = 0;
        state = STATE_IDLE;
    }
    else {
        gravity = HERO_GRAVITY;
    }
}
