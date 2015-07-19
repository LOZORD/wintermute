require 'json.rb'
require_relative './block_group.rb'
require_relative './markov_engine.rb'

# TODO: comment
class Level
  MAX_WIDTH   = 50
  MAX_HEIGHT  = 50
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

  def add_group (x, y, group_name)
    group = @block_groups.select { |block| block.name == group_name }.first
    fail "EXPECTED BlockGroup, but ACTUALLY #{ group.class }" unless group.is_a? BlockGroup
    if !((2...width-1).cover?(x) &&
        (2...height-1).cover?(y) &&
        (2...width-1).cover?(x + group.width) &&
        (2...height-1).cover?(y + group.height))
      fail 'Tried to add group out of bounds!'
    end

    group.blocks.each_with_index do |row, j|
      row.each_with_index do |block, i|
        grid[x + i][y + j].type = block.type
      end
    end
  end

  def generate!
  end
  def grid_to_s (together = false)
    if together # as one single string
      (self.grid_to_s false).join("\n")
    else # as an array
      grid.map do |row|
        row.reduce('') { |str, block| str += block.char }
      end
    end
  end

  def to_s
    { width: width, height: height, grid: self.grid_to_s }.to_s
  end
end
