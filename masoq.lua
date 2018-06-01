require "header"
linhas = 0

local tokenm={};
local contadorToken=0;

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
      local token = c
      --ai meu deus
      if isMenor(c) then
          i=i+1
          c = word:sub(i,i)
          if isMaior(c) and i<=len then
              token = token .. c
              --salva operador diferente
              contadorToken = contadorToken + 1;
              print(contadorToken,"diferente",token)
          elseif isIgual(c) and i<=len then
              token = token .. c
              --salva operador menor igual
              contadorToken = contadorToken + 1;
              print(contadorToken,"Menor igual", token)
          else
              i=i-1
              c = word:sub(i,i)
              contadorToken = contadorToken + 1;
              print(contadorToken,"menor", token)
          end
      elseif  isMaior(c) then
          i=i+1
          c = word:sub(i,i)
          
          if isIgual(c) and i<=len then
              token = token .. c
              --salva operador maior igual
              contadorToken = contadorToken + 1;
              print(contadorToken,"maior igual",token)
          else
              i=i-1
              c = word:sub(i,i)
              --salva operador maior 
              contadorToken = contadorToken + 1;
              print(contadorToken,"maior",token)
          end
      
      elseif  isIgual(c) then
          i=i+1
          c = word:sub(i,i)
          
          if isIgual(c) and i<=len then
              token = token .. c
              --salva operador igualdade
              contadorToken = contadorToken + 1;
              print(contadorToken,"igual",token)
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
              contadorToken = contadorToken + 1;
              print(contadorToken,"binario com mais de dois simbolos",token)
          else
              --salva numero binario
              contadorToken = contadorToken + 1;
              print(contadorToken,"binario",token)
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
              contadorToken = contadorToken + 1;
              --salva token com marca de erro
              print(contadorToken,"Hexa com mais de 16 simbolos",token)
          else
              contadorToken = contadorToken + 1;
              --salva numero hexa
              print(contadorToken,"Hexa",token)
          end
          
      elseif isPV(c) then
          --salva pronto e virgula
          contadorToken = contadorToken + 1;
          print(contadorToken,"charles",token)
          
      elseif  isDP(c) then
          i=i+1
          c = word:sub(i,i)
          if(i<=len and isIgual(c)) then
              token = token .. c
              --salva operador atribuição
              contadorToken = contadorToken + 1;
              print(contadorToken,"atribuição", token)
          else
              i=i-1
              --salva ::::
              contadorToken = contadorToken + 1;
              print(contadorToken,"dois pontos", token)
          end  
      
      elseif  isMenos(c) then
          --salva menos
          contadorToken = contadorToken + 1;
          print(contadorToken,"menos",token)
          
      elseif  isAritmetico(c) then
          --salva operador
          contadorToken = contadorToken + 1;
          printf(contadorToken,"operador",token)
          
      elseif isAlpha(c) then
          i=i+1
          c = word:sub(i,i)
          while(i<=len and identificador(c))do
            token = token .. c
            i=i+1
            c = word:sub(i,i)
          end
          i=i-1
          --verifica e salva palavra
          contadorToken = contadorToken + 1;
          print(contadorToken,"palavra",token);
      elseif isAspa(c) then
          --salva aspa
          contadorToken = contadorToken + 1;
          print(contadorToken,"aspa", token)
      elseif isAspas(c) then
          --salva aspas
          contadorToken = contadorToken + 1;
          print(contadorToken,"aspas",token)
          
      elseif isAChave(c) then
          --salva abrechave
          contadorToken = contadorToken + 1;
          print(contadorToken,"Achave",token)
      elseif isAParente(c) then
          --salva abreParenteses
          contadorToken = contadorToken + 1;
          print(contadorToken,"Aparente",token)
        
      elseif isAColchete(c) then
          --salva abreColchete
          contadorToken = contadorToken + 1;
          print(contadorToken,"AColchete",token)
          
      elseif isBChave(c) then
          --salva fechachave
          contadorToken = contadorToken + 1;
          print(contadorToken,"Bchave",token)
          
      elseif isPonto(c) then
          i=i+1
          c = word:sub(i,i)
          if(isPonto(c))then
              -- opa dois pontos
              contadorToken = contadorToken + 1;
              print(contadorToken,"aqueles dois pontos",token)
          else
              -- tem?
              contadorToken = contadorToken + 1;
              i=i-1
              print(contadorToken,"um ponto",token)
          end
          
      elseif isBParente(c) then
          --salva fechaParenteses
          contadorToken = contadorToken + 1;
          print(contadorToken,"Bparente",token)
          
      elseif isBColchete(c) then
          --salva fechaColchete
          contadorToken = contadorToken + 1;
          print(contadorToken,"BColchete",token)
          
      elseif isDec(c) then
          i=i+1
          c = word:sub(i,i)
          print(len,word);
          local hmm = true
          while(i<=len and isDec(c)) do
              token = token .. c
              i=i+1
              c = word:sub(i,i)
          end
          --ok
          print("opa", i , c);
          if(i<=len and not isDec(c)) then
              if colado(c) then
                  -- ou n salva numero
                  contadorToken = contadorToken + 1;
                  print(contadorToken,"numero1",token)
                  i=i-1
              elseif (isPonto(c)) then
                  local d = word:sub(i+1,i+1);
                  if(isPonto(d))  then
                      contadorToken = contadorToken +1;
                      print(contadorToken,"numero ant",token);
                      token = "..";
                      contadorToken = contadorToken +1;
                      print(contadorToken,"numero3",token);
                      hmm = false;
                  else
                      hmm = true;
                  end
              else
                  token = token .. c
                  i=i+1
                  c = word:sub(i,i)
                  while(i<=len and isDec(c)) do
                      token = token .. c
                      i=i+1
                      c = word:sub(i,i)
                  end
              end
              if(i<=len and not isDec(c)) then
                  if colado(c) then
                      -- salva numero
                      contadorToken = contadorToken +1;
                      print(contadorToken,"numero2",token);
                      i=i-1;
                      --elseif ()
                      --salva erro no numero
                      token = token .. c
                      hmm = false
                      --print("não possui apenas numeros1", token)
                      i=len+1
                  else
                      contadorToken = contadorToken + 1;
                      print(contadorToken,"float1",token)
                      --salva numero com numero decimal
                      contadorToken = contadorToken + 1;
                  end
              else --i>len
                  --salva 
                  contadorToken = contadorToken + 1;
                  print(contadorToken,"float2",token)
                  hmm = false
              end
          else
              --salva erro no numero
              token = token .. c
              hmm = false
              contadorToken = contadorToken + 1;
              print(contadorToken,"não possui apenas numeros2", token)
              i=len+1
            end
          end--s
          if hmm then
            --salva  numero normal
            contadorToken = contadorToken + 1;
            print(contadorToken,"numero hmm",token)
          end
      --end
      i=i+1
    end
  end
end

file = 'pascal.txt';
f = io.open(file, "rb");
  if f == nil then 
    --print("deu ruim") 
  end

for line in io.lines(file) do
  linhas = linhas + 1;
  getTokens(line,linhas)
end