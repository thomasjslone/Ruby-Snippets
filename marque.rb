@wrapper = "|"
@width = 25
@width_l = @width - 1
@delay = 20
@fps = 0.050
@direction = 0
@str = "Hello World, I am Ruby and I can do lots! I can say hello world, and your mother."
@spacer = ""
@space = " "
@delay_spacer = ""
@delay.times { @delay_spacer << @space }
@vspacer = @spacer.to_s + @delay_spacer + @str.to_s
@width.times { @spacer << @space.to_s}
thread = Thread.new {  loop do
                         s = @vspacer.split("")
                         if @direction == 0
						   m = s[1..-1].join("").to_s
                           m << s[0].to_s
						 elsif @direction == 1
						   m = s[-1].to_s
						   m << s[0..-2].join("").to_s
						 end
						 @vspacer = m.to_s
						 @spacer = @vspacer.to_s.split("")[0..@width_l.to_i].join("").to_s
						 @canvas = @wrapper.to_s + @spacer.to_s + @wrapper.to_s
    			  	     sleep @fps.to_f
                      end
                    }

thread2 = Thread.new { loop do
#  puts " Whole String: \"" + @vspacer.to_s + "\"" + " Progresion Rate: " + @fps.to_s + " seconds per cycle. Delay Width: " + @delay.to_s 
  puts @canvas.to_s
  print "\r\e[A"# + "\r\e[A"
  sleep @fps.to_f				     
end
}
loop do
end
