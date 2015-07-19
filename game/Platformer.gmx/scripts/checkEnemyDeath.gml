var player = instance_place(x,bbox_top,Player);

if (instance_exists(player)){
    if (player.dead == false){
        if (player.vspeed > 0){
            if (player.bbox_bottom > bbox_top){
                instance_destroy();
                player.vspeed = -6;
            }
        }
    }

}
