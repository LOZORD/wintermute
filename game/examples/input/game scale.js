
var game = new Phaser.Game(320, 240, Phaser.CANVAS, 'phaser-example', { preload: preload, create: create, update: update, render: render });

function preload() {

    //  This sets a limit on the up-scale
    game.scale.maxWidth = 800;
    game.scale.maxHeight = 600;

    //  Then we tell Phaser that we want it to scale up to whatever the browser can handle, but to do it proportionally
    game.scale.scaleMode = Phaser.ScaleManager.SHOW_ALL;
    game.scale.setScreenSize();

    game.load.image('melon', 'assets/sprites/melon.png');

}

var cursors;

function create() {

    //  Increase the size of our game world
    game.world.setBounds(0, 0, 2000, 2000);

    for (var i = 0; i < 1000; i++)
    {
        //  And spread some sprites inside it
        game.add.sprite(game.world.randomX, game.world.randomY, 'melon');
    }

    cursors = game.input.keyboard.createCursorKeys();

}

function update() {

    //  This allows us to move the game camera using the keyboard

    if (cursors.left.isDown)
    {
        game.camera.x -= 2;
    }
    else if (cursors.right.isDown)
    {
        game.camera.x += 2;
    }

    if (cursors.up.isDown)
    {
        game.camera.y -= 2;
    }
    else if (cursors.down.isDown)
    {
        game.camera.y += 2;
    }

}

function render() {

    game.debug.inputInfo(16, 16);

}
