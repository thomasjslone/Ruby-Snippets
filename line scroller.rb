@wrapper = "|"
@width = 25
@width_l = @width - 1
@spacer = ""
@space = " "
@dot  = "O"
@width.times { @spacer << @space.to_s }
@pos = 0
@delay = 0.025
@canvas = @wrapper.to_s + @spacer.to_s + @wrapper.to_s
t = Thread.new { loop do
  s = @spacer.split("")
  s[@pos.to_i] = @dot.to_s
  if @pos.to_i == 0
    ri = @width_l.to_i
  else
    ri = @pos - 1
  end
  s[ri.to_i] = @space.to_s
  @spacer = s.join("").to_s
  @canvas = @wrapper.to_s + @spacer.to_s + @wrapper.to_s

  if @pos.to_i == @width_l.to_i
    @pos = 0
  else
    @pos += 1
  end
  sleep @delay.to_f
end
}
thread2 = Thread.new {  loop do
                            if @pos.to_s.length == 1
    pl = @pos.to_s + "   "
  elsif @pos.to_s.length == 2
    pl = @pos.to_s + "  "
  else
    pl = @pos.to_s
  end
                          puts " Pos:" + pl.to_s
                          puts @canvas.to_s
                          print "\r\e[A" + "\r\e[A"                     
                          sleep @delay.to_f
						end
					 }
loop do ## this loop will keep the consol from closing when this file is clicked
end