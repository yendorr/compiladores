linhas = 0
function  getToken(line,linhas)
  for word in string.gmatch(line, '[^ \n]+') do
    print(word);
  end
end

file = 'pascal.txt'
f = io.open(file, "rb")
  if f == nil then print("deu ruim") else print("deu bom") end

for line in io.lines(file) do 
  linhas = linhas + 1; 
  getToken(line,linhas)
end

