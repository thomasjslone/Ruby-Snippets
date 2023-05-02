  def prime?
    return false if self <= 1
    (2..Math.sqrt(self)).each do |i|
      return false if self % i == 0
    end
    return true
  end
