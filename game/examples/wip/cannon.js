
// var game = new Phaser.Game(800, 600, Phaser.AUTO, 'phaser-example', { preload: preload, create: create, update: update, render: render });
var game = new Phaser.Game(800, 600, Phaser.CANVAS, 'phaser-example', { preload: preload, create: create, update: update, render: render });

function preload() {

    // game.load.image('arrow', 'assets/sprites/arrow.png');
    game.load.image('arrow', 'assets/sprites/thrust_ship2.png');
    game.load.image('chunk', 'assets/sprites/chunk.png');
    game.load.image('box', 'assets/sprites/block.png');
    game.load.spritesheet('bullets', 'assets/sprites/balls.png', 17, 17);

}

var cannon;
var bullets;
var angle = 0;
var fireRate = 100;
var nextFire = 0;
var cursors;
var boxes;
var playerGroup;
var bulletGroup;
var boxGroup;

function create() {

    game.stage.backgroundColor = '#2d2d2d';

    game.physics.gravity[1] = -8.5;
    game.physics.defaultRestitution = 0.8;
    game.physics.defaultFriction = 0.1;

    bullets = game.add.group();
    bullets.createMultiple(250, 'bullets', 0, false);

    cannon = game.add.sprite(50, 500, 'arrow');
    cannon.name = 'ship';
    cannon.physicsEnabled = true;
    cannon.body.setCircle(32);

    playerGroup = game.physics.createCollisionGroup();
    bulletGroup = game.physics.createCollisionGroup();
    boxGroup = game.physics.createCollisionGroup();

    cannon.body.setCollisionGroup(playerGroup);
    cannon.body.collides(boxGroup);

    boxes = game.add.group();

    for (var i = 0; i < 30; i++)
    {
        var box = boxes.create(game.rnd.integerInRange(100, 700), game.rnd.integerInRange(100, 500), 'box');
        box.name = 'box' + i;
        box.scale.set(game.rnd.realInRange(0.2, 0.7));
        box.physicsEnabled = true;
        box.body.setCollisionGroup(boxGroup);
        box.body.collides( [ playerGroup, bulletGroup, boxGroup ]);
    }

    cursors = game.input.keyboard.createCursorKeys();

}

function fire() {

    if (game.time.now > nextFire)
    {
        nextFire = game.time.now + fireRate;

    	var bullet = bullets.getFirstExists(false);

        if (bullet)
        {
            bullet.frame = game.rnd.integerInRange(0,6);
            bullet.exists = true;
            bullet.position.set(cannon.x, cannon.y);
            bullet.physicsEnabled = true;
            bullet.body.collideWorldBounds = false;
            bullet.body.rotation = cannon.rotation - game.math.degToRad(90);

            var magnitude = game.math.px2p(-500);
            var angle = bullet.body.rotation + Math.PI / 2;

            bullet.body.velocity.x = magnitude * Math.cos(angle);
            bullet.body.velocity.y = magnitude * Math.sin(angle);

            bullet.body.setCollisionGroup(bulletGroup);
            bullet.body.collides(boxGroup);
        }
    }

}

function update() {

    if (cursors.left.isDown)
    {
        cannon.body.rotateLeft(100);
    }
    else if (cursors.right.isDown)
    {
        cannon.body.rotateRight(100);
    }
    else
    {
        cannon.body.setZeroRotation();
    }

    if (cursors.up.isDown)
    {
        // cannon.body.moveForward(200);
        cannon.body.thrust(200);
    }
    else if (cursors.down.isDown)
    {
        // cannon.body.moveBackward(200);
        cannon.body.reverse(200);
    }

    var dx = game.input.activePointer.worldX - cannon.x;
    var dy = game.input.activePointer.worldY - cannon.y;
    cannon.rotation = Math.atan2(dy, dx);

    if (game.input.activePointer.isDown)
    {
        fire();
    }

}

function render() {

    game.debug.physicsBody(cannon.body);

}
