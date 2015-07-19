/*
    Call in the Player object step event

*/

if (keyboard_check_pressed(ord('W'))){
    if (place_free(x,y-HERO_JUMP_SPEED)){
        if (!place_free(x,y+1)){
            vspeed = -HERO_JUMP_SPEED;
            state = STATE_JUMP;
        } else if (state == STATE_JUMP){
            state = STATE_DJUMP;
            vspeed = -HERO_JUMP_SPEED;
        } else if (state == STATE_GRAB){
            vspeed = -HERO_JUMP_SPEED;
            if (!place_free(x-HERO_GRAB_DIST,y)){
                hspeed = HERO_MOVESPEED;
            } else {
                hspeed = -HERO_MOVESPEED;
            }
            state = STATE_JUMP;
        }
    }
}
