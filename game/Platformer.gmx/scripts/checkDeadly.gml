/*
    Call within Player object
    
    checks if the player is colliding with a deadly obstacle


*/
var deadly = instance_place(x,y-3,parDeadly);

if (dead == false){
    if (instance_exists(deadly)){
        //call the death event, which contains the death function
        event_user(0);
        with(deadly){
            if (destructable){
                instance_destroy();
            }
        }
    }
}
