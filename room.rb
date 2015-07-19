class Room
  attr_accessor :walls, :x, :y
  attr_writer :start, :finish, :layout_path, :solution_path
  def initialize (x, y, **walls)
    @x = x
    @y = y
    @walls = {
      north:  walls[:north] || false,
      east:   walls[:east]  || false,
      south:  walls[:south] || false,
      west:   walls[:west]  || false
    }
    @start = walls[:start] || false
    @finish = walls[:finish] || false
    @layout_path = false
    @solution_path = false
  end

  def start?
    @start
  end

  def finish?
    @finish
  end

  def layout_path?
    @layout_path
  end

  def solution_path?
    @solution_path
  end

  def neigbors
    [
      { x: x + 1, y: y },
      { x: x - 1, y: y },
      { x: x, y: y + 1 },
      { x: x, y: y - 1 }
    ]
  end

end
