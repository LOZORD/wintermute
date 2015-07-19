require_relative './block.rb'
# TODO: comment
class BlockGroup
  attr_accessor :filename, :name, :blocks, :width, :height
  # @@known_block_groups ||= {}
  # @@id_ctr ||= @@id_ctr
  def initialize(**options)
    @filename = './block-groups/' + options[:filename]
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
