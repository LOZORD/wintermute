require 'json.rb'
require_relative './block_group.rb'

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
