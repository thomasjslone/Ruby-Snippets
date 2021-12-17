class Coder ## basic and somwwhat crude string encoding for text files and program data strings
  def initialize
    ##below is a list of all the characters you can make with a keyboard (excluding windows alt numkey function)
    @kbchars = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","0","1","2","3","4","5","6","7","8","9","-","+","_","=","[","]","{","}","|","\\","/",":",";",",",".","?","<",">","\"","'","`","~","!","@","#","$","%","^","&","*","(",")","\n","\t"," "]
    ## if you shuffle the @kbchars variable above, you can make your own encoding keys and pass them to the enc/dec methods
	@chbytes = [] ## here we will just convert them to bytes, we want them to all be numbers below 100 and above 0
	@kbchars.each { |ch| @chbytes << ch.to_s.bytes[0].to_s } ## there is 97 characters including tabs and line breaks ("\n")
  end
  def enc(str)
    key = @chbytes   ## this is where you can plug different keys into the method
    str = str.to_s.split("") ## first we split the given string into an array of character strings
	bytes = [] ## the bytes will go here
	str.each do |ch|                           ## so first step is to get a list of the bytes of each character
      bytes << ch.to_s.bytes[0].to_s
    end
	tablea = []
	bytes.each do |b|                          ## the second step is to turn the bytes into index numbers determined by the order of the key
	  tablea << @chbytes.index(b.to_s).to_i
	end
	tableb = []
	tablea.each do |c|                         ## the third step is to add 2 to each index value to eliminate the 0 values
	  tableb << c.to_i + 2
	end
	tablec = []
	i = 2	
    tableb.each do |c|                         ## each character index is now multiplied by a number relative to its position in the string
	  tablec << c.to_i * i.to_i
	  i += 1
	end
	t = tablec.join("334455").to_s             ## now we use the smallest yet least likley number to occur, some keys might give issues and others not, this will be a big area for improvements             
    return t.to_i * 2                          ## final step is multiplying the result data one more time, to mask the 334455 seperators we used to join the characters
	end 
  def dec(str)                                 ## everything here on out is the above, encoding backwards and in reverse
    key = @chbytes
	str = str.to_i / 2
    str = str.to_s.split("334455")
	i = 2
	tableb = []
	str.each do |c|
	  tableb << c.to_i / i.to_i
	  i += 1
	end
	tablea = []
	tableb.each do |c|
	  tablea << c.to_i - 2
	end
	bytes = []
	tablea.each do |c|
	  bytes << key[c.to_i].to_s
	end
	str = []
	bytes.each do |byte|
	  str << byte.to_i.chr.to_s
	end
	return str.join("").to_s
  end
end