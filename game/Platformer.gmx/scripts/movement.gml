/*

    argument0 = the "up" key


*/

if (!dead){
    var movementSpeed= 4;
    
    if (!place_free(x,y+vspeed)){
        gravity = 0;
       
        move_contact_solid(270,vspeed); 
        vspeed = 0;
    }
    else {
        gravity = 1;
    }
    
    if (keyboard_check(ord('W'))){
        if (!place_free(x,y+1)){
            vspeed = -10;
        }
    }
    
    if (keyboard_check(ord('A'))){
        if (place_free(x-4,y-3)){
            x -= movementSpeed;
        }
    } else if (keyboard_check(ord('D'))){
        if (place_free(x+4,y-3)){
            x += movementSpeed;
        }
    }
}
