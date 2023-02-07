c=0;s=nil; 100.times{c+=1
  print c.to_s+" "
  if c % 3 == 0 ;  print "FIZZ";  s=true;  end
  if c % 5 == 0 ;  print "BUZZ ";  s=false;  end
  if s;  print " ";  s=false;  end}
