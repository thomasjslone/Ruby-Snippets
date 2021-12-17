@perc = 0
t = Thread.new { loop do ; @perc += 1 ; sleep 0.15 ; end }  
until @perc == 100   
  puts "Downloading: (" + @perc.to_s + "%)"
  print "\r"   #carret to beginning of line
  print "\e[A" #carret up one line
  sleep 0.050
end
puts "Downloading: (100%)"
#print "\r\e[A"  
puts "\nDonload Complete"