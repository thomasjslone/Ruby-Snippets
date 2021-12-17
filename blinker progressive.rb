@states = ["A","B","C","D","E","F","G","H"]
@canvas = " "
@index = 0
@index_l = @states.length.to_i - 1
@blink = 0.250
@direction = 0
blinker = Thread.new {  loop do
                          @canvas = @states[@index].to_s
						  if @direction == 0
						    if @index.to_i == @index_l.to_i
						      @index = 0
						    else
						      @index += 1
						    end
						  elsif @direction == 1
						    if @index.to_i == 0
						      @index = @index_l.to_i
						    else
							  @index -= 1
							end
						  end
						  sleep @blink.to_f
                        end
                     }
loop do
  if @index.to_s.length == 1
    l = "  "
  elsif @index.to_s.length == 2
    l = " "
  else
    l = ""
  end
  puts " State: " + @index.to_s + l.to_s + " Rate: " + @blink.to_s + " seconds per cycle"
  puts @canvas.to_s
  print "\r\e[A" + "\r\e[A"
  sleep @blink.to_f
end