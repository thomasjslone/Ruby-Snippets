## this timer had to be adjusted to run well in threads, turns out a thread that does a somewhat
## complicated loop one thousand times per second is still too heavy to run on your average desktop pc
## this timer increments its millisecond counter by 250 four times per second, which is  much more managable
## running in two threads

## Note: still not accurate. this timer out races the non-threaded timer

@timer = [0,0,0,0]   # hours # minutes # seconds # milliseconds
@canvas = ""         # this is where the screen will wait to be drawn to the consol window
@ticker = 0.250      # this controls much long of a second to wait before repeating a loop
thread = Thread.new {  loop do
                         if @timer[3] == 1000    ## timer count up branch
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
					       @timer[3] += 250
					     end
						 if @timer[-1].to_s.length == 1    ## keep millisecond slot three digits at all times for astetics
						   ms = "00" + @timer[-1].to_s
						 elsif @timer[-1].to_s.length == 2
						   ms = "0" + @timer[-1].to_s
						 elsif @timer[-1].to_s.length == 3
						   ms = @timer[-1].to_s
						 end
					     @canvas = @timer[0..-2].join(":").to_s + ":" + ms.to_s
					     sleep @ticker.to_f
					   end
                    }
thread2 = Thread.new { loop do   ##
  puts " Timer.rb"
  puts @canvas.to_s
  print "\r\e[A" + "\r\e[A"
  sleep 0.250
end
}
loop do
end

