  def fibcurve(n)
    a = 0; b = 1; c = []
    str = "*" * n
    n.times do |i|
      s = " " * [i, n-i-1].min
      c << (s + str[i..-1] + s.reverse)
      a = b;  b = a + b
    end
	return c
  end
