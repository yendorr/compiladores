require "header"
linhas = 0
a = {}
function getTokens(line,linhas)
  for word in string.gmatch(line, '[^ \n]+') do
    for i = 1, #word do
      local c = word:sub(i,i+1)
      --a[linhas][i] = c;
      --print(a[linhas][i])
    end
    --print(word)
    local i = 1
    local len = word:len()
    
    while i<=len do
      c = word:sub(i,i)
      token = c
      --ai meu deus
      if isMenor(c) then
          i=i+1
          c = word:sub(i,i)
          if isMaior(c) and i<=len then
              token = token .. c
              --salva operador diferente
              print("diferente",token)
          elseif isIgual(c) and i<=len then
              token = token .. c
              --salva operador menor igual
              print("igual", token)
          else
              i=i-1
              c = word:sub(i,i)
              print("menor", token)
          end
      elseif  isMaior(c) then
          i=i+1
          c = word:sub(i,i)
          
          if isIgual(c) and i<=len then
              token = token .. c
              --salva operador maior igual
              print("maior igual",token)
          else
              i=i-1
              c = word:sub(i,i)
              --salva operador maior 
              print("maior",token)
          end
      
      elseif  isIgual(c) then
          i=i+1
          c = word:sub(i,i)
          
          if isIgual(c) and i<=len then
              token = token .. c
              --salva operador igualdade
              print("igual",token)
          else
              i=i-1
          end
      elseif  isComercial(c) then
          i=i+1
          c = word:sub(i,i)
          
      
      elseif  isPorcento(c) then
          i=i+1
          c = word:sub(i,i)
          while(i<=len and isBin(c)) do
              token = token .. c
              i=i+1
              c = word:sub(i,i)
          end
          if(i<=len and not isBin(c)) then
              token = token .. c
              i=len+1
              --salva token com marca de erro
              print("binario com mais de dois simbolos",token)
          else
              --salva numero binario
              print("binario",token)
          end
          
      elseif  isSifrao(c) then
          i=i+1
          c = word:sub(i,i)
          while(i<=len and isHexa(c)) do
              token = token .. c
              i=i+1
              c = word:sub(i,i)
          end 
          if(i<=len and not isHexa(c)) then
              token = token .. c
              i=len+1
              --salva token com marca de erro
              print("Hexa com mais de 16 simbolos",token)
          else
              --salva numero hexa
              print("Hexa",token)
          end
      
      elseif  isDP(c) then
          i=i+1
          c = word:sub(i,i)
          if(i<=len and isIgual(c)) then
              token = token .. c
              --salva operador atribuição
              print("atribuição", token)
          else
              i=i-1
              --salva ::::
              print("dois pontos", token)
          end  
      
      elseif  isMenos(c) then
          --salva menos
          print("menos",token)
      
      elseif  isAritmetico(c) then
          --salva operador
          printf("operador",token)
          
      elseif isAlpha(c) then
        --i=i+1
        --c = word:sub(i,i)
        --while( )do
          
        --end
      
      elseif isAspas(c) then
      
      elseif isAChave(c) then
      
      elseif isAParente(c) then
      
      elseif isAChave(c) then
      
      elseif isDec(c) then
          i=i+1
          c = word:sub(i,i)
          while(i<=len and isDec(c)) do
              token = token .. c
              i=i+1
              c = word:sub(i,i)
          end
          if(i<=len and not isDec(c)) then
            if colado(c) then
            -- salva numero
            print("numero1",token)
            i=i-1
            elseif (isPonto(c)) then
                token = token .. c
                i=i+1
                c = word:sub(i,i)
                while(i<=len and isDec(c)) do
                    token = token .. c
                    i=i+1
                    c = word:sub(i,i)
                end
                if(i<=len and not isDec(c)) then
                  if colado(c) then
                  -- salva numero
                  print("numero2",token)
                  i=i-1
                  else
                      --salva erro no numero
                    token = token .. c
                    print("não possui apenas numeros1", token)
                    i=len+1
                  --else
                    --print("float",token)
                    --salva numero com numero decimal
                  end
                end
            else
                --salva erro no numero
                token = token .. c
                print("não possui apenas numeros2", token)
                i=len+1
            end
          end
      end
      i=i+1
    end
    
  end
end

file = 'pascal.txt'
f = io.open(file, "rb")
  if f == nil then 
    print("deu ruim") 
  end

for line in io.lines(file) do 
  linhas = linhas + 1; 
  getTokens(line,linhas)
  a[linhas] = {};

end
  