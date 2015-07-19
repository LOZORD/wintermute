require 'json.rb'
require 'set'
require_relative './block_group.rb'
require_relative './markov_engine.rb'
require_relative './room.rb'

# TODO: comment
class Level
  MAX_WIDTH   = 50
  MAX_HEIGHT  = 50
  ROOM_SIZE = 10
  @@rng = nil
  attr_accessor :grid, :width, :height, :difficulty, :m, :path
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
    @m = MarkovEngine.new('./genre-markov.json', @@rng)
    @path = []
    @rooms = [] #Array.new(@width/ROOM_SIZE) { Array.new (@height/ROOM_SIZE, false) }
    setup!
    # generate!
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
    @path = []
    @rooms = Array.new(@width/ROOM_SIZE) { |x| Array.new (@height/ROOM_SIZE) { |y| Room.new(x,y) } }
    #@rooms.last.last = true # mark the finish room as true
    #@finish_room = @rooms.last.last
  end

  def add_group (x, y, group_name)
    group = @block_groups.select { |block| block.name == group_name.to_s }.first
    fail "EXPECTED BlockGroup, but ACTUALLY #{ group.class }" unless group.is_a? BlockGroup
    if !((2...width-1).cover?(x) &&
        (2...height-1).cover?(y) &&
        (2...width-1).cover?(x + group.width) &&
        (2...height-1).cover?(y + group.height))
      fail "Tried to add group out of bounds! (x: #{ x }, y: #{ y })"
    end

    group.blocks.each_with_index do |row, j|
      row.each_with_index do |block, i|
        grid[x + i][y + j].type = block.type
      end
    end
    # TODO return final x,y
  end

  def in_finish_room? (x, y)
    # @rooms.size == x && @rooms.last.size == y
    @rooms[x][y].finish?
  end

  def a_star(s, f)
    closedSet     = Set.new
    openSet       = Set.new [s]
    navigatedSet  = Set.new

    g_score = {}
    g_score[s] = 0
    f_score = {}
    f_score[s] = g_score[s] + heuristic_cost(s, f)

    until openSet.empty?
      current = openSet.min_by { |a, b| f_score[a] <=> f_score[b] }

      if current = f
        return reconstruct_path(navigatedSet, f)
      end

      openSet.delete current

      closedSet.add current

      # iterate thru neighbors
      current.neighbors.each do |neighbor|
        if (0...@rooms.size).cover?(neighbor[:x]) &&
          (0...@rooms[0].size).cover?(neighbor[:y])
          neighbor = @rooms[neighbor[:x]][neighbor[:y]]
        else
          return nil
        end
        if closedSet.member? neighbor
          next
        end

        # distance from current to neighbor is always one
        tentative_g_score = g_score[current] + 1 
        neighbor_g_score = g_score[neighbor] || Float::Infinity
        if !openSet.member?(neighbor) || tentative_g_score < neighbor_g_score
          navigatedSet[neighbor] = current
          g_score[neighbor] = tentative_g_score
          f_score[neighbor] = g_score[neighbor] + heuristic_cost(neighbor, f)
          unless openSet.member? neighbor
            openSet.add neighbor
          end
        end
      end
    end
    return nil
  end

  def heuristic_cost (a, b)
    dx2 = (a.x - b.x).abs2
    dy2 = (a.y - b.y).abs2
    return Math::sqrt(dx2 + dy2)
  end

  def reconstruct_path(came_from, current)
    total_path = [current]
    while came_from.member? current
      current = came_fromt[current]
      total_path << current
    end
    return total_path
  end

  def generate!
    self.add_group(2, 2, 'start')
    @start_room = @rooms.first.first
    self.add_group(width - 10, height - 10, 'finish')
    @finish_room = @rooms.last.last
    room_path = a_star(@start_room, @finish_room)
    puts room_path
  end


  """
  def generate!
    self.add_group(2, 2, 'start')
    self.add_group(width - 1, height - 1, 'finish')
    # complete_level(width - 1, height - 1)
    complete_level
  end

  def complete_level
    blocks_tried = []

    while blocks_tried.size < 10
      new_block = heuristic blocks_tried
      add_group new_block
      # reacheable?
    end
  end
  """

  """
  def generate!
    self.add_group(2, 2, 'start')
    @rooms.first.first.start = true
    self.add_group(width - 1, height - 1, 'finish')
    @rooms.last.last.finish = true
    # @rooms.last.last = true # mark the finish room as true
    @start_room = @rooms.first.first
    @finish_room = @rooms.last.last
    findPathThruRooms(x, y, minDist)
  end
  """

  """
  def findPathThruRooms(x, y, minDist)
    if !(0...@rooms.size).cover?(x) || !(0...@rooms[0].size).cover?(y)
      return false
    end

    if @rooms[x][y].finish? && minDist.zero?
      return true
    elsif @rooms[x][y].closed?
      return false
    else
      @rooms[x][y].layout_path = true
      rand_dir = [:n, :e, :s, :w][@@rng.rand(4)]
      case rand_dir
        # TODO check bounds
      when :n
        return findPathThruRooms(x, y - 1, minDist - 1)
      when :e
        return findPathThruRooms(x + 1, y, minDist - 1)
      when :s
        return findPathThruRooms(x, y - 1, minDist - 1)
      when :w
        return findPathThruRooms(x - 1, y, minDist - 1)
      end
      @rooms[x][y].solution_path = false
    end
  end
  """

  """
  def findPathThruRooms(x, y, minDist)
    if in_finish_room?(x, y) && minDist == 0
      true
    elsif @rooms[x][y] == false # FIXME
      false
    else
      @path << { x: x, y: y }
      rand_dir = [:n, :e, :s, :w][@@rng.rand(4)]
      case rand_dir
        # TODO check bounds
      when :n
        findPathThruRooms(x, y - 1, minDist - 1)
      when :e
        findPathThruRooms(x + 1, y, minDist - 1)
      when :s
        findPathThruRooms(x, y - 1, minDist - 1)
      when :w
        findPathThruRooms(x - 1, y, minDist - 1)
      # unmark (x,y) as part of current solution path

  end
  """

  # FIXME
  """
  def generate!
    self.add_group(2, 2, 'start')
    next_steps = m.next(:start)
    puts next_steps
    nx = ny = -1
    while not (next_steps.member? :finish)
      next_steps.each do |genre|
        # FIXME: pseudocode
        group = genre.get_group_in_direction(x,y)
        nx, ny = grid.add_group x, y, group
      end
      next_steps = m.next(next_steps.last)
      puts next_steps
    end
  end
  """

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
