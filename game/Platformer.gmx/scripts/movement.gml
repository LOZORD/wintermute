/*

    argument0 = the "up" key


*/

if (keyboard_check(ord('A'))){
    if (place_free(x-(hspeed+accel),y-3)){
        if (state == STATE_IDLE){
            state = STATE_WALK;
        }
        var top_speed = HERO_MOVESPEED;
        if (keyboard_check(vk_shift)){
            top_speed = HERO_RUNSPEED;
        }
        
        if (hspeed - accel > -top_speed){
            hspeed -= accel;
        }
    }
} else if (keyboard_check(ord('D'))){
    if (place_free(x+(hspeed+accel),y-3)){
        if (state == STATE_IDLE){
            state = STATE_WALK;
        }
        var top_speed = HERO_MOVESPEED;
        if (keyboard_check(vk_shift)){
            top_speed = HERO_RUNSPEED;
        }
        
        if (hspeed + accel < top_speed){
            hspeed += accel;
        }
    }
}

if (!keyboard_check(ord('A')) && !keyboard_check(ord('D'))){
    if (hspeed != 0){
        hspeed -= sign(hspeed);
    }
    if (state == STATE_WALK){
        state = STATE_IDLE;
    }
}
