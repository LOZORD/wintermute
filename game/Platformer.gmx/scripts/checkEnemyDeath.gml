var player = instance_position(x,bbox_top,Player);

if (instance_exists(player)){
    if (player.vspeed > 0){
        instance_destroy();
        player.vspeed = -6;
    }

}
