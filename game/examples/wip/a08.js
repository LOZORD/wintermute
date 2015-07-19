
var game = new Phaser.Game(800, 600, Phaser.AUTO, 'phaser-example', { preload: preload, create: create, update: update });

function preload() {

    game.load.atlas('atlas', 'assets/sprites/seacreatures_json.png', 'assets/sprites/seacreatures_json.json');

}

var sprite;

function create() {

    sprite = game.add.sprite(400, 200, 'atlas', 'greenJellyfish0000');
    sprite.anchor.set(0.5);

    sprite.animations.add('swim', Phaser.Animation.generateFrameNames('greenJellyfish', 0, 38, '', 4), 30, true);
    sprite.play('swim');

    game.input.onDown.add(changeTint, this);

}

function changeTint() {

    sprite.tint = Math.random() * 0xffffff;

}

function update() {

    sprite.rotation += 0.02;

}
