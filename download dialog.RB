@perc = 0
t = Thread.new { loop do ; @perc += 1 ; sleep 0.050 ; end }  
until @perc == 100   
  puts "Downloading: (" + @perc.to_s + "%)"
  print "\r\e[A"
  sleep 0.050
end
t.kill
puts "Downloading: (100%)"
print "\r\e[A"  
puts "\nDownload Complete"
@perc = 0
t = Thread.new { loop do ; @perc += 1 ; sleep 0.050 ; end }  
until @perc == 100   
  puts "Downloading: (" + @perc.to_s + "%)"
  print "\r\e[A"
  sleep 0.050
end
t.kill
puts "Downloading: (100%)"
print "\r\e[A"  
puts "\nDownload Complete"
@perc = 0
t = Thread.new { loop do ; @perc += 1 ; sleep 0.050 ; end }  
until @perc == 100   
  puts "Downloading: (" + @perc.to_s + "%)"
  print "\r\e[A"
  sleep 0.050
end
t.kill
puts "Downloading: (100%)"
print "\r\e[A"  
puts "\nDownload Complete"
puts "Press enter to exit."
gets