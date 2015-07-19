/*
    Call within Player step event
    
    checks for walls in the vertical direction so that we dont move into walls.
*/


if (vspeed < 0){
    if (!place_free(x+hspeed,y+vspeed)){
        move_contact_solid(90,abs(vspeed));
        hspeed = 0;
    }
}
