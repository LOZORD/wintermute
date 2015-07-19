
var game = new Phaser.Game(800, 600, Phaser.AUTO, 'phaser-example', { preload: preload, create: create });

function preload() {

    game.load.image('grid', 'assets/tests/debug-grid-1920x1920.png');
    game.load.image('atari', 'assets/sprites/atari800xl.png');

}

function create() {

    game.add.sprite(0, 0, 'grid');

    var atari1 = game.add.sprite(300, 300, 'atari');

    //  Input Enable the sprites
    atari1.inputEnabled = true;

    //  Allow dragging - the 'true' parameter will make the sprite snap to the center
    atari1.input.enableDrag(true);

}
