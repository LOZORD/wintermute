require 'json.rb'
# require 'set.rb'

# measured in block sizes
MAX_WIDTH = 150
MAX_HEIGHT = 150

# TODO: comment
class Block
  @@block_types ||= JSON.parse(File.read('./tile-types.json'), symbolize_names: false)
  attr_accessor :type
  def initialize(type = :empty)
    if type.is_a? Symbol
      @type = type
    elsif type.is_a? String
      @type = @@block_types[type]['type'].to_sym
    end
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
  attr_accessor :grid, :width, :height, :difficulty

  def initialize(**options)
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
  end

  def generate!
  end
end

diff = ARGV.first || 1

block_groups = [
  'start',
  'finish',
  'vertical-barrier',
  'horizontal-barrier',
  'spike-pit'
]

lvl = Level.new difficulty: diff, block_groups: block_groups

puts lvl.grid
puts lvl.height
