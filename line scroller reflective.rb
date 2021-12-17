@str = ""
@width = 25
@space = " "
@pixel = "O"
@wrapper = "|"
@index_l = @width - 1
@spacer = ""
@direction = 0
@clock = 0.025  ## 40 fps
@width.times { @spacer << @space.to_s}
@i = 0
thread = Thread.new {
loop do
  s = @spacer.split("")
  s[@i.to_i] = @pixel.to_s
  if @direction == 0
    if @i.to_i == 0
      ri = @index_l.to_i
    else
      ri = @i - 1
    end
  elsif @direction == 1
    if @i.to_i == @index_l.to_i
      ri = 0
    else
      ri = @i + 1
    end
  end
  s[ri.to_i] = @space.to_s
  @spacer = s.join("").to_s
  @canvas = @wrapper.to_s + @spacer.to_s + @wrapper.to_s
  if @direction == 0
    if @i.to_i == @index_l.to_i
      @i = @index_l.to_i - 1
	  @direction = 1
    else
      @i += 1
    end
  elsif @direction == 1
    if @i.to_i == 0
	  @i = 1
	  @direction = 0
	else
	  @i -= 1
	end
  end  
  sleep @clock.to_f
end
}
loop do
  if @i.to_s.length == 1
    pl = @i.to_s + "   "
  else
   pl = @i.to_s + "  "
  end
  puts " Pos:" + pl.to_s
  puts @canvas.to_s
  print "\r\e[A" + "\r\e[A"
  sleep @clock.to_f
end