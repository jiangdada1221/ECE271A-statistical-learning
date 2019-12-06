function output = zigSecond_large(input)
   [a,index] = sort(input,"descend");
   output = index(2);
end