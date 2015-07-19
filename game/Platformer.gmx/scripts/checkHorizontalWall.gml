/*
    Call within Player step event
    
    checks for walls in the horizontal direction so that we dont move into walls.
*/


if (!place_free(x+hspeed,y-3)){
    
    if (hspeed < 0){
        move_contact_solid(180,abs(hspeed));
    } else if (hspeed > 0){
        move_contact_solid(0,hspeed);
    }
    hspeed = 0;
}
