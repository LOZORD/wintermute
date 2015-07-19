/*
    Passin the string of the JSON file for read in. something something i need some sleep.
    
    ZzzzzZzzzzZzzzzz....

*/

//var new_room = room_add();

var resultMap = json_decode(argument0);

var levelNum = ds_map_find_value(resultMap,"levelNum");
var width = ds_map_find_value(resultMap,"width");
var height =  ds_map_find_value(resultMap,"height");

var level =  ds_map_find_value(resultMap,"level");

room_width = width * 64;
room_height = height * 64;

for (var i = 0 ; i < width;i++){
    for (var j = 0; j < height; j++){
        var char = string_char_at(level[|j],i);
        switch (char){
            case " ":
                break;
            case "^":
                instance_create(64*i,64*j+32,Wall);
                room_tile_add(room,backTileset,choose(32,96),0,64,64,64*i,64*j+32,10);
                instance_create(64*i,64*j,Spike);
                break;
            case "0":
                instance_create(64*i,64*j,Wall);
                room_tile_add(room,backTileset,choose(32,96),0,64,64,64*i,64*j,10);
                break;
            case "S":
                instance_create(64*i+32,64*j,Start);
                break;
            case "F":
                instance_create(64*i+32,64*j,Finish);
                break;
            case "r":
                var rocket = instance_create(64*i+32,64*j+32,RocketLauncher);
                rocket.direction = 180;
                break;
            case "R":
                var rocket = instance_create(64*i+32,64*j+32,RocketLauncher);
                rocket.direction = 0;
                break;
            case "P":
                var rocket = instance_create(64*i+32,64*j+32,RocketLauncher);
                rocket.direction = 90;
                break;
            case "p":
                var rocket = instance_create(64*i+32,64*j+32,RocketLauncher);
                rocket.direction = 270;
                break;
            case "D":
                instance_create(64*i+32,64*j+32,Disk);
                break;
            case "E":
                instance_create(64*i+32,64*j+32,Disk);
                break;
            
            
        }
    }
}

ds_list_destroy(level);
ds_map_destroy(resultMap);

instance_create(Start.x,Start.y,Player);
view_object = Player;
//room_assign(new_room,room);
//room_goto(new_room);
