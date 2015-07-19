/*
    Call within the Player step event

*/

vspeed = 0;
hspeed = 0;
gravity = 0;

if (!keyboard_check(ord('A')) && !keyboard_check(ord('D'))){
    state = STATE_JUMP;
}
