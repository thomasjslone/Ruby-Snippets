@timer = [0,0,0,0]
@canvas = ""
@ticker = 0.001 ## wont run at 0.001?!?! any more suddenly, wtf thread programming is pretty terrible in ruby, ill give you that
thread = Thread.new {  loop do
                         if @timer[3] == 1000
                           @timer[3] = 0
						   if @timer[2] == 59
					          @timer[2] = 0
							  if @timer[1] == 59
							    @timer[1] = 0
							    @timer[0] += 1
							  else
							    @timer[1] += 1
							  end
					       else
						     @timer[2] += 1
						   end
					     else
					       @timer[3] += 1
					     end
						 if @timer[-1].to_s.length == 1
						   ms = "00" + @timer[-1].to_s
						 elsif @timer[-1].to_s.length == 2
						   ms = "0" + @timer[-1].to_s
						 elsif @timer[-1].to_s.length == 3
						   ms = @timer[-1].to_s
						 end
					     @canvas = @timer[0..-2].join(":").to_s + ":" + ms.to_s

					     sleep 0.001
					   end
                    }
loop do
  puts " Timer.rb"
  puts @canvas.to_s
  print "\r\e[A" + "\r\e[A"
  sleep 0.100
end


