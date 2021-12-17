@state1 = "O"
@state2 = " "
@canvas = @state1.to_s
@visable = true
@blink = 0.250
blinker = Thread.new {  loop do
                          if @visable
						    @canvas = @state2.to_s
							@visable = false
						  else
						    @canvas = @state1.to_s
                            @visable = true
                          end
						  sleep @blink.to_f
                        end
                     }
loop do
  if @visable
    l = " "
  else
    l = ""
  end
  puts " State: " + @visable.to_s + l.to_s + " Rate: " + @blink.to_s + " seconds per cycle"
  puts @canvas.to_s
  print "\r\e[A" + "\r\e[A"
  sleep @blink.to_f
end