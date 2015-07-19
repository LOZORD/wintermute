/*


*/

switch (gender){
    case MALE:
        if (dead){
            sprite_index = sprPlayerMaleDeath;
        } else {
            sprite_index = sprPlayerMale;
        }
        break;
    case FEMALE:
        if (dead){
            sprite_index = sprPlayerFemaleDeath;
        } else {
            sprite_index = sprPlayerFemale;
        }
        break;
}
