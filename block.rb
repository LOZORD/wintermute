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
