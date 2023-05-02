  def parse_seconds(s)
    s = s.to_i
    if s < 60 ;  [0, 0, s]
    elsif s < 3600 ; [0, s / 60, s % 60]
    elsif s < 86400 ; [s / 3600, (s / 60) % 60, s % 60]
    else
      days = s / 86400
      hours = (s / 3600) % 24
      minutes = (s / 60) % 60
      seconds = s % 60
      [days, hours, minutes, seconds]
    end
  end
