require_relative './level.rb'

seed_val  = ARGV[0].to_i || 1234
diff      = ARGV[1] || 1
block_groups = Dir.entries('./block-groups').keep_if do |filename|
  filename.end_with? '.json'
end
puts block_groups

lvl = Level.new seed: seed_val, difficulty: diff, block_groups: block_groups

# puts lvl.to_s

puts lvl.grid_to_s true
