/*
    Call within the Enemy objects
    
    uses alarm[0] as the attack alarm

*/

var player = noone;
if (facing == 1){
    player = collision_rectangle(bbox_right,y-16,bbox_right+16,y,Player,false,true);
} else {
    player = collision_rectangle(bbox_left,y-16,bbox_left-16,y,Player,false,true);
}


if (alarm[0] == -1){
    if (instance_exists(player)){
        with (player){
            //call the player's death event
            event_user(0);
        }    
    }
}
