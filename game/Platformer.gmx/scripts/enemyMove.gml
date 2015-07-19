wall = instance_place(x,y+3, Wall);

if(instance_exists(wall)){
    if((wall.x + (sprite_width >> 1)) > x){
        hspeed = maxspeed;
    } else if(((wall.x + wall.sprite_width) - (sprite_width >> 1))< x){
        hspeed = -maxspeed;
    }
};
