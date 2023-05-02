def parse_array *args
    if args.length > 0 ;  str = args[0]
    else;  str = self
    end
	if str.to_s == "[]";  return [];  end
	
	str = str.strip.gsub(/^\[|\]$/, '')
    elements = [];  current_element = '';  nested_level = 0
  
    str.each_char do |c|
      if c == ',' && nested_level == 0
        elements << current_element.strip
        current_element = ''
      else
        current_element += c
        if c == '[';  nested_level += 1
        elsif c == ']';  nested_level -= 1
        end
      end
    end
  
    elements << current_element.strip
  
    elements.map do |element|
      if element.start_with?('"') && element.end_with?('"')
        element.gsub(/^"|"$/, '')
      elsif element.start_with?("'") && element.end_with?("'")
        element.gsub(/^'|'$/, '')
      elsif element =~ /\A\d+\z/
        element.to_i
      elsif element =~ /\A\d+\.\d+\z/
        element.to_f
      elsif element == 'true' || element == 'false'
        element == 'true'
      elsif element.start_with?('[') && element.end_with?(']')
        self.parse_array(element)
      elsif element.start_with?('{') && element.end_with?('}')
        self.parse_hash(element)
      else
        element
      end
    end
  end


  def parse_hash *args
    if args.length == 0;  str = self
    else;  str = args[0]
    end
    if str.to_s == "{}";  return {};  end
	
    str = str.strip.gsub(/^\{|\}$/, '')
    pairs = [];  current_key = '';   current_value = '';  nested_level = 0

    str.each_char do |c|
      if c == '>' && nested_level == 0
        current_key = current_value.gsub(/['":]\s*(\w+)\s*['":]?/, '\1');  current_key = current_key.delete(" =")
        current_value = ''
      elsif c == ',' && nested_level == 0
        pairs << [current_key, current_value.strip]
        current_key = ''
        current_value = ''
      else
        current_value += c
        if c == '{' || c == '['
          nested_level += 1
        elsif c == '}' || c == ']'
          nested_level -= 1
        end
      end
    end

    pairs << [current_key, current_value.strip]

    hash = {}
    pairs.each do |pair|
      key = pair[0]
      value = pair[1]

      if value.start_with?('{') && value.end_with?('}')
        hash[key] = value.parse_hash
      elsif value.start_with?('[') && value.end_with?(']')
        hash[key] = value.parse_array
      elsif value == 'true'
        hash[key] = true
      elsif value == 'false'
        hash[key] = false
      elsif value =~ /\A\d+\z/
        hash[key] = value.to_i
      elsif value =~ /\A\d+\.\d+\z/
        hash[key] = value.to_f
      else
        hash[key] = value.gsub(/^\"|\"$/, '')
      end
    end
	
    return hash
  end
