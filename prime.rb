def prime? n 
  rv=true;c=1;l=n-1 
  until c>=l
    c+=1
    if (n.to_f/c.to_f).to_s.split(".")[-1].to_i==0
      rv=false;c=n
    end    
  end
  return rv
end