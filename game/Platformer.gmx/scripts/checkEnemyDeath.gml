var player = instance_position(x,bbox_top,Player);

if (instance_exists(player)){
    if (player.vspeed > 0){
        if (player.y > bbox_top){
            instance_destroy();
            player.vspeed = -6;
        }
    }

}
