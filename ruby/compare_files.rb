@a = []
f = File.open('bacula.txt') do |f|
  f.lines.each do |line|
   #@a << line.split.map()
    @a << line

 end
  puts "file 1: #{@a.size}"
end
@b = []
f = File.open('unxwebp08.txt') do |f|
  f.lines.each do |line|
   #@b << line.split.map()
    @b << line
    
    @c = @a - @b
    @intersection = @a & @b
 end
  puts "file 2: #{@b.size}"
end
puts "Lines in common: #{@intersection.size}"

puts "These lines are not common to both:"
puts @c
