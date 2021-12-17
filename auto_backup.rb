## App Name:               Auto Backup
## Manufacturer:           Thomas Technical
## Version:                1.0.2
## Release Date:           2016-5-23
##
## Description:            Ruby one click auto backup copies files and folders to a safe location such as an sd card
class Auto_Backup
  def initialize()
    @back_dir = "C:/Users/Jacob/Desktop/"
    @dest_dir = "D:/projects/" 
    @included_formats = []               # if none will include all formats, if not none then includes only listed formats
    @included_fnames = []                # if none will include all names, if not none then includes only listed names
    @included_dnames = []                # same as above but for directories
    @excluded_formats = ["lnk","ini"]    # any formats listed here will be excluded before the final backup process
    @excluded_fnames = ["consol.bat"]    # any files with matching names will be excluded if they were included  
    @excluded_dnames = []                # excludes directories with matching names if were inlcuded
    @include_files = true                # switch to include all files in back up, kind of pointless unless you want to back up empty directories
    @include_folders = true             # switch to inlcude all folders in backup
	@log_operations = true               # log backup info like time, files involved and locations.	
	@bkf = []
	@bkd = []
	bk(Dir.getwd.to_s)
  end
  def bk(dir)
    if File.directory?(dir)
      map = map_directory(dir)
	  tsize = format_size(directory_size(@back_dir).to_s).to_s + " bytes"
      @fdat = []
	  if @include_files
	    map[1].to_a.each do |fp| ############### read file data
		  if @included_formats.length == 0
		    if @included_fnames.length == 0
		      ##no inclusion discrimination
		      f = File.open(fp.to_s,"r")
		      @fdat << f.read.to_s
		      f.close
		    elsif @included_fnames.length > 0
		      ##no format discrimination but discriminate fname
			  if @included_fnames.include?(fp.to_s.split("/")[-1].to_s)
			    f = File.open(fp.to_s,"r")
		        @fdat << f.read.to_s
		        f.close
			  end
		    end
	      elsif @included_formats.length > 0
		    if @included_fnames.length == 0
		      ##yes format discrimination, no name discrimination
		      if @included_formats.include?(fp.split("/")[-1].to_s.split(".")[-1].to_s)
			    f = File.open(fp.to_s,"r")
		        @fdat << f.read.to_s
		        f.close
			  end
		    elsif @included_fnames.length > 0
		      ##yes format discrimination, yes name discrimination
			  if @included_fnames.include?(fp.to_s.split("/")[-1].to_s)
			    if @included_formats.include?(fp.split("/")[-1].to_s.split(".")[-1].to_s)
			      f = File.open(fp.to_s,"r")
		          @fdat << f.read.to_s
		          f.close
			    end
			  end
		    end
		  end
		end
	  end
	  if @include_folders
	    map[0].each do |d|  #################################### create subdirectories		
		  d = d.gsub(@back_dir, "").to_s
		  if @included_dnames.length < 1
		    unless @excluded_dnames.include?(d.to_s)
		      @bkd << @dest_dir.to_s + d.to_s
		      if File.directory?(@dest_dir.to_s + d.to_s) == false
		        Dir.mkdir(@dest_dir.to_s + d.to_s)
		      end
		    end
		  else
		    if @included_dnames.include?
		      unless @excluded_dnames.include?(d.to_s)
			    @bkd << @dest_dir.to_s + d.to_s
		        if File.directory?(@dest_dir.to_s + d.to_s) == false
		          Dir.mkdir(@dest_dir.to_s + d.to_s)
		        end
		      end
		    end
		  end
        end
	  end 
	  nfps = []
      if @include_files
	    map[1].each do |fp| ## create new file paths
	      nfps <<	@dest_dir.to_s + fp.split(@back_dir.to_s.split("/")[-1].to_s + "/")[-1].to_s
	    end
	    i = 0
        nfps.each do |fp|   ########## create files and write data ## exclusion discrimination is worked out here.
		  if @excluded_formats.length == 0
		    ## no formats to exclude
		    if @excluded_fnames.length == 0
		      ## no fnames to exclude
		      f = File.open(fp.to_s,"w")
			  f.write(@fdat[i].to_s)
			  f.close
			  @bkf << fp.to_s
		    elsif @excluded_fnames.length > 0
		      ##exclude fnames but not formats
		      unless @excluded_fnames.include?(fp.split("/")[-1].to_s)
			    f = File.open(fp.to_s,"w")
			    f.write(@fdat[i].to_s)
			    f.close
			    @bkf << fp.to_s
		      end
		    end	
		  elsif @excluded_formats.length > 0
		    if @excluded_fnames.length == 0
		      ## format exclusion, but no fnames to exclude
              unless @excluded_formats.include?(fp.split(".")[-1].to_s)
			    begin
				  f = File.open(fp.to_s,"w")
			      f.write(@fdat[i].to_s)
			      f.close
			      @bkf << fp.to_s
				rescue
				end
		      end
		    elsif @excluded_fnames.length > 0
		      ##exclude fnames and formats
		      unless @excluded_fnames.include?(fp.split("/")[-1].to_s)
			    unless @excluded_formats.include?(fp.split("/")[-1].to_s.split(".")[-1].to_s)
			      f = File.open(fp.to_s,"w")
				  f.write(@fdat[i].to_s)
				  f.close
				  @bkf << fp.to_s
			    end
			  end
		    end
		  end
		  i += 1
	    end
      end
	  if @log_operations
	    label = "\n\n< Backed Up: " + @back_dir.to_s + " ; " + Time.now.to_s.split(" ")[0..1].join(", ").to_s + ", Files: " + @bkf.length.to_s + ", Folders: " + @bkd.length.to_s + ">\n{" 
	    label << "\n" + @bkd.join("\n").to_s + "\n" + @bkf.join("\n").to_s + "\n}\nTotal Data Backed Up: " + tsize.to_s
	    f = File.open(@dest_dir.to_s + "log.txt","a")
	    f.write(label.to_s)
	    f.close
	  end
	  puts "Backup Complete:   From: " + @back_dir.to_s + " To: " + @dest_dir.to_s
	  puts "Files: " + @bkf.length.to_s + " , Folders: " + @bkd.length.to_s
	  puts "Total Data Backed Up: " + tsize.to_s
	  puts "Press ENTER to exit."
	  gets
	  exit
      return true
    else
	  return false
	end
  end
  def map_directory(dir) ## can be string or array of strings
    files = []
	subdirectories = []
	remaining_directories = [dir.to_s]
	until remaining_directories.length.to_i == 0
      cd = remaining_directories[0]
 	  begin
	    Dir.foreach(cd) do |d|
		  if d.to_s != "." and d.to_s != ".."
	        if File.file?(cd.to_s + "/" + d.to_s)
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
	return [subdirectories,files] ##this array of two arrays will be considered a mapping
  end  
  def directory_size(dir)
    files = []
	subdirectories = []
	remaining_directories = [dir.to_s]
	until remaining_directories.length.to_i == 0
      cd = remaining_directories[0]
 	  Dir.foreach(cd) do |d|
		if d.to_s != "." and d.to_s != ".."
	      if File.file?(cd.to_s + "/" + d.to_s)
		    files << cd.to_s + "/" + d.to_s  
		  elsif File.directory?(cd.to_s + "/" + d.to_s)
			remaining_directories << cd.to_s + "/" + d.to_s
		  end
		end
	  end
	  remaining_directories.delete_at(0)
	end
	size = 0
	files.each do |f|
	  size += File.size(f).to_i
	end
	return size.to_i
  end 
  def format_size(n)
    str = ''
	s = n.to_s.split("").reverse
	i=0
	s.each do |nc|
	  if i == 2
	    i=0
		str << nc.to_s + ","
	  else
	    str << nc.to_s
		i+=1
	  end
	end
	if str.to_s[-1].to_s == ","
	  str = str.reverse.to_s.split("")[1..-1].join("").to_s
	else
	  str = str.reverse.to_s
	end
	return str
  end
end
$ab = Auto_Backup.new()