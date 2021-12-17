@wrapper = "|"
@dot = "O"
@space = " "
@width = 25
@progress = 0
@growth_rath = 0.2
@grid = ""
@width.times { @grid << " " }
@canvas = @wrapper.to_s + @grid.to_s + @wrapper.to_s

thread = Thread.new { loop do
                        if @progress.to_i <= @width.to_i
                          d = @grid.to_s.split("")
                          d[@progress] =  @dot.to_s
						  @grid = d.join("").to_s
						  @canvas = @wrapper.to_s + @grid.to_s + @wrapper.to_s
                          @progress += 1
						else
						  break
						end
					    sleep 0.2
				  	  end
                    }
loop do
  puts " Progress: " + "(" + @progress.to_s + "/" + @width.to_s + ")"
  puts @canvas.to_s
  print "\r\e[A" + "\r\e[A"
  sleep 0.2
end