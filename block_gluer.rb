require 'json.rb'
# require 'set.rb'

# measured in block sizes
MAX_WIDTH = 50
MAX_HEIGHT = 50

# TODO: comment
class Block
  @@block_types ||= JSON.parse(File.read('./block-types.json'), symbolize_names: false)
  @@type_to_char = @@block_types.keys.reduce({}) do |obj, char|
    puts obj
    someSym = (@@block_types[char]['type'].to_sym)
    puts someSym
    obj[someSym] = char
    obj
  end

  attr_accessor :type
  def initialize(type = :empty)
    if type.is_a? Symbol
      @type = type
    elsif type.is_a? String
      char = type
      @type = @@block_types[char]['type'].to_sym
    else
      fail 'UNKNOWN TYPE: ' + type.to_s
    end
  end

  def type= (other_type)
    fail 'NOT A SYMBOL!' unless other_type.is_a? Symbol
    fail 'UNKNOWN TYPE!' unless @@type_to_char.has_key? other_type
    @type = other_type
  end

  def char
    @@type_to_char[type].to_s
  end
end

# TODO: comment
class BlockGroup
  attr_accessor :filename, :name, :blocks, :width, :height
  # @@known_block_groups ||= {}
  # @@id_ctr ||= @@id_ctr
  def initialize(**options)
    @filename = './blocks/' + options[:filename]
    fail 'NEED A FILENAME!' unless @filename
    parse = JSON.parse(File.read(@filename), symbolize_names: true)
    p parse
    @name = options[:name] || options[:filename] || parse[:name]
    block_arr = options[:blocks] || parse[:blocks]
    @width = options[:width] || parse[:width]
    @height = options[:height] || parse[:height]
    @blocks = Array.new(@width) do |x|
      Array.new(@height) { |y| Block.new block_arr[y][x] }
    end
  end
end

# TODO: comment
class Level
  @@rng = nil
  attr_accessor :grid, :width, :height, :difficulty
  def initialize(**options)
    @@rng ||= Random.new options[:seed].to_i
    @difficulty = options[:difficulty]
    @width = options[:width] || MAX_WIDTH
    @height = options[:height] || MAX_HEIGHT
    @block_groups = options[:block_groups].map do |group_name|
      group_name = group_name + '.json' unless group_name.end_with? '.json'
      BlockGroup.new filename: group_name
    end
    @grid = Array.new(@width) { Array.new(@height) { Block.new } }
    setup!
    generate!
  end

  def setup!
    (0...width).each do |x|
      grid[x][0].type = :barrier
      grid[x][height-1].type = :barrier
    end

    (0...height).each do |y|
      grid[0][y].type = :barrier
      grid[width-1][y].type = :barrier
    end
  end

  def generate!
  end
  def grid_to_s
    grid.map do |row|
      row.reduce('') { |str, block| str += block.char }
    end
  end

  def to_s
    { width: width, height: height, grid: self.grid_to_s }.to_s
  end
end

seed_val = ARGV[0].to_i || 1234
diff = ARGV[1] || 1

block_groups = [
  'start',
  'finish',
  'vertical-barrier',
  'horizontal-barrier',
  'spike-pit'
]

lvl = Level.new seed: seed_val, difficulty: diff, block_groups: block_groups

puts lvl.to_s
