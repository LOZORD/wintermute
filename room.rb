class Room
  attr_accessor :walls, :x, :y
  attr_writer :start, :finish
  def (x,y, **walls)
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
  end

  def start?
    @start
  end

  def finish?
    @finish
  end
end
