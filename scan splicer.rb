  def splice(b,e)  
    if b.is_a?(String) == false or e.is_a?(String) == false;  raise "Arguements require String type."
	elsif b.to_s=="" or e.to_s == "";  raise "Arguements cannot be nilstring."
	end
	s=self  ## self inside the loop will not be the string
    if s.length<=(b.to_s.length+e.to_s.length);  raise "Base string is too small.";  end
    pos=0;  stack = false;  list=[]
    if b.length > e.length ;  buffer_length = b.length;  else;  buffer_length = e.length;  end
    buffer = []; buffer_length.times{ buffer << "" }
    empty_buffer=[]; buffer_length.times{ empty_buffer << "" }  ## again, in the loop we can only refer to vars
    empty_buffer2=[]; buffer_length.times{ empty_buffer2 << "" } ## im really not sure why but id love to know
    tag1=empty_buffer; b.split('').each { |ch| empty_buffer << ch ;  empty_buffer.delete_at(0) }
    tag2=empty_buffer2; e.split('').each { |ch| empty_buffer2 << ch ;  empty_buffer2.delete_at(0) }
    loop do ## in this loop s will be self and tag1 & 2 will point to the buffers we want to work with
      if s[pos].to_s=="";  break;  end	
      buffer << s[pos];  buffer.delete_at(0)
	  if stack;  list << s[pos];  end
	  str=buffer.join('');  tag = tag1.join('')
      m=true;  i=0
      tag.reverse.split('').each{ |ch| if ch.to_s!=str.reverse[i].to_s and ch.to_s != ""; m=false; break; end; i+=1 }	
      if m == true;  stack = true;  end
	  tag = tag2.join('')
      m=true;  i=0
      tag.reverse.split('').each{ |ch| if ch.to_s!=str.reverse[i].to_s and ch.to_s != ""; m=false; break; end; i+=1 }	
	  if m == true;  stack = false;  end
	  pos+=1
    end
    if list.length == 0;  return nil  ##not nilstring so we can tell the difference on return side
    else;  return list.join('')[0..("-"+(e.length+1).to_s).to_i]
    end 
  end
