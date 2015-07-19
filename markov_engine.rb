require 'json'

# TODO: comment
class MarkovEngine
  attr_accessor :lut, :difficulty_scaling

  def initialize(filename)
    hash = JSON.parse(File.read(filename), symbolize_names: true)
    @lut = hash[:lut] || {}
    @difficulty_scaling = hash[:difficulty_scaling] || {}
  end

  def next(curr_state, **options)
    fail 'Current state needs to be a symbol!' unless curr_state.is_a? Symbol
    itrs = options[:iterations] || 3 # prob(2nd & 3rd | curr)
    diff = options[:difficulty] || 1

    next_rec(curr_state, itrs, diff)
  end

  def next_rec(curr_state, itrs, diff)
    return [] if curr_state == :finish # TODO: work with final state somehow...
    # normalized_nexts = normalize(curr_state)
    return [] if itrs.zero?
    # TODO: what to do with difficulty? ---> BUFF LIKELIHOOD OF HAZARDS
    possible_nexts = @lut[curr_state]
    sum = possible_nexts.values.reduce(:+)
    thold = rand(0...sum) # non-inclusive
    next_state = pull_next_state(thold, 0, possible_nexts.to_a)

    [next_state] + next_rec(next_state, itrs - 1, diff)
  end

  def pull_next_state(threshhold, curr_count, state_arr)
    fail "EMPTY STATE ARRAY!" if state_arr.empty?
    head_state = state_arr.slice! 0
    if curr_count + head_state.last > threshhold
      head_state.first # the next state symbol
    else
      puts "RECURSING! THRESHOLD: #{ threshhold }\tARRAY: #{ state_arr }"
      pull_next_state(threshhold, curr_count + head_state.last, state_arr)
    end
  end

  """
  def normalize(curr_state)
    possibilities = @lut[curr_state]
    sum   = possibilities.values.sum

    # XXX smoothing?
    possibilities.keys.reduce({}) do |obj, next_state|
      obj[next_state] = (possibilities[next_state]) / sum
    end
  end
  """
end
