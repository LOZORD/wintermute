
var game = new Phaser.Game(800, 600, Phaser.AUTO, 'phaser-example', { preload: preload, create: create, update: update });

var filter;
var sprite;

function preload() {

    //  From http://glslsandbox.com/e#20193.0
    game.load.shader('bacteria', 'assets/shaders/bacteria.frag');

}

function create() {

    filter = new Phaser.Filter(game, null, game.cache.getShader('bacteria'));

    filter.setResolution(800, 600);

    sprite = game.add.sprite();
    sprite.width = 800;
    sprite.height = 600;

    sprite.filters = [ filter ];

}

function update() {

    filter.update();

}
