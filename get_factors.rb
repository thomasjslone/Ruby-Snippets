def factors
    n = self;  factor1 = 1;  factor2 = n
    (2..Math.sqrt(n)).each do |factor|
      if n % factor == 0
        factor1 = factor
        factor2 = n / factor
        break
      end
    end
    [factor1, factor2]
  end
