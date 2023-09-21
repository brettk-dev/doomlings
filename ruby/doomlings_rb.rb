Player = Struct.new(:name, :score)

def get_int()
  input = nil
  while not input
    input = Integer(gets.chomp, exception: false)
  end
  return input
end

def get_name(n)
  puts "What is player #{n}'s name"
  input = gets.chomp
  return input.length > 0 ? input : "Player #{n}"
end

def get_score(name, type)
  puts "What is #{name}'s #{type} score?"
  return get_int
end

puts
puts ":::: DOOMLINGS SCORE CALCULATOR ::::"

puts
puts "How many people are playing?"
player_count = 0
while player_count < 1
  player_count = get_int
end
players = Array.new(player_count).map {|_| Player.new("", 0)}

puts
players.each_with_index do |player, index|
  player.name = get_name index + 1
end

puts
players.each do |player|
  player.score += get_score player.name, "World's End"
end

puts
players.each do |player|
  player.score += get_score player.name, "Face Value"
end

puts
players.each do |player|
  player.score += get_score player.name, "Bonus"
end

puts
puts
puts "#".ljust(2) + "PLAYER".ljust(16) + "SCORE".rjust(5)
puts
players.sort_by(&:score).reverse.each_with_index do |player, index|
  puts (index + 1).to_s.ljust(2) + player.name.ljust(16) + player.score.to_s.rjust(5)
end