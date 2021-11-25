def def number_surname(int)
  int=int.to_i; if int==0;return "0";end
  if int=="11";int="11th"
  elsif int =="12";int="12th"
  elsif int =="13";int="13th"
  elsif int[-1].to_s=="1";int=int+"st"
  elsif int[-1].to_s=="2";int=int+"nd"
  elsif int[-1].to_s=="3";int=int+"rd"
  else;int=int+"th"
  return int.to_s
end