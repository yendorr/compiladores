require "Lexico"
contador = 0
TK = 0

function avanca()
    contador = contador + 1
    TK = token[contador]
    --print(TK.texto)
end

function recua()
    contador = contador - 1
    TK = token[contador]
end

function determina(buffer,torp)
    return determina2(buffer,1,contadorIdentificadores)
end
function determina2(buffer,i,j,torp)
    m = math.floor( (i+j)/2)
    if m == 0 then return false end
    if buffer == identificador[m].texto then
        identificador[contadorIdentificadores].tipo = torp
        return m 
    end
    if i>=j then
        return false
    end
    if buffer < identificador[m].texto then
        return buscaBinaria(buffer,i,m-1,torp)
    else
        return buscaBinaria(buffer,m+1,j,torp)
    end
end



function main()
    print("--------------------------------------SS-------------------")
    avanca()
    print( "execução completa:", progrm())
    print(TK.texto , token[contador].linha,token[contador].coluna)
    
end

function sitype()
  
    -- trecho 3  
    if (TK.tipo == "identificador") then --TYIDEN
        return true
    end
    
    -- trecho 4
    if (TK.texto == "(") then
        avanca()
        if (TK.tipo== "identificador") then --IDEN
            avanca()
            while (TK.texto == ",") do
                avanca()
                if TK.tipo ~= "identificador" then --IDEN
                    return false
                end
                avanca()
            end
            if (TK.texto == ")") then
                return true
            end
        end
        return false
    end
    
    --trecho 5
    if const() then
        avanca()
        if (TK.texto == "..") then
            avanca()
            return const()
        end
    end
    
    return false
end

function const()
    -- trecho 1
    if (TK.tipo == "string") then
        avanca()
        return true
    end
    
    -- trecho 2
    if (TK.texto == "+" or TK.texto == "-") then
        avanca()
        
        if (TK.tipo == "identificador" or TK.tipo == "numero") then --COIDEN
            return true
        end
    end
  
    return false
end

function tipo() -- type é uma palavra reservada do lua, logo type sera tipo
    -- trecho 6
    if(TK.tipo == "reservada" and TK.texto ~= "array")then return true end
    if (TK.texto=="=")then--|
        avanca()
        
        if (TK.tipo == "identificador") then --TYIDEN
            return true
        end
        return false
    end
    
    --trecho 7
    if (TK.texto == "packed") then
        avanca()
    end
    
    --trecho 8
    if (TK.texto == "array") then
        avanca()
        if (TK.texto == "[")then
            avanca()
            if sitype() then
                avanca()
                while (TK.texto == ",") do
                    avanca()
                    if(not sitype()) then
                        return false
                    end
                    avanca()
                end
                if (TK.texto == "]") then
                    avanca()
                    if(TK.texto == "of") then
                        avanca()
                        return tipo()
                    end  
                end
                
            end
        end
        return false
    end
    
    --trecho 9
    if (TK.texto == "file") then
        avanca()
        
        if(TK.texto == "of") then
            avanca()
            return tipo()
        end
        return false
    end
    
    --trecho 10
    if (TK.texto == "set") then
        avanca()
        
        if (TK.texto == "of") then
            avanca()
            return sitype()
        end
    end
    
    --trecho 11
    if (TK.texto == "record") then
        avanca()
        
        if (filist()) then
            avanca()
            if (TK.texto == "end") then
                return true
            end
        end
        return false
    end
    --trecho 12
    return sitype()
end

function filist()
    --trecho 13
    if (TK.tipo == "identificador") then
        avanca()
        if(TK.texto == ",") then
            avanca()
            return filist()
        end
        if (TK.texto == ":") then
            avanca()
            if(tipo()) then
                avanca()
            else
                return false
            end
        else
            return false
        end
    end
    
    if (TK.texto == ";") then
        avanca()
        return filist()
    end
    
    
    
    --trecho 14
    if (TK.texto == "case") then
        avanca()
        if (TK.tipo == "identificador") then
            avanca()
            if(TK.texto ~= ",") then
                return false
            end
            avanca()
        end
        if (TK.tipo == "identificador") then --TYIDEN
            avanca()
            if (TK.texto == "of") then
                avanca()
                return trecho15()
            end
        end
    end
    recua()
    return true -- lambda
end

function trecho15()
    if (TK.tipo == "string") then
        avanca()
        return trecho16()
    else
        if(TK.texto == "+" or TK.texto == "-") then
            avanca()
            if (TK.tipo ~= "identificador" and TK.tipo ~= "numero") then -- COIDEN
                return false
            end 
        end
        if(TK.tipo == "identificador" or TK.tipo == "numero")then --COIDEN
            avanca()
            return trecho16()
        end
    end
    if(TK.texto == ";") then
        return trecho15()
    end
    
    recua() 
    return true -- lambada
end

function trecho16()
    if (TK.texto == ",")then
        return trecho15()
    end
    if (TK.texto ~= ":")then
        return false
    end
    avanca()
    if (TK.texto ~= "(")then
        return false
    end
    avanca()
    if(not filist()) then
        return false
    end
    avanca()
    if (TK.texto ~= ")")then
        return false
    end
    avanca()
    if(TK.texto == ";")then
        return trecho15()
    end
    
    recua()
    return true
end

function infipo()
    --trecho 17
    if(TK.texto == "[")then
        repeat
            avanca()
            if(not expr()) then
              return false
            end
            avanca()
        until TK.texto ~= ","
        if(TK.texto ~= "]")then
            return false
        end
        avanca()
        return infipo()
    end
    
    --trecho 18
    if (TK.texto == ".")then
        avanca()
        if(TK.tipo ~="identificador")then -- FIIDEN
            return false
        end
        avanca()
        return infipo()
    end
    
    if (TK.texto == "=")then -- |
        avanca()
        return infipo()
    end
    recua()
    return true
end

function factor()
  --trecho 
    if (TK.tipo == "identificador")then --COIDEN
        return true
    end
    
    if (TK.tipo == "numero" ) then
        return true
    end
    
    if (TK.texto == "nil") then
        return true
    end
    
    if (TK.tipo == "string") then
        return true
    end
    
    if (TK.tipo == "identificador") then --VAIDEN
        return infipo()
    end
    
    --trecho 20
    if (TK.tipo == "identificador") then --FUIDEN
        if(TK.texto == "(") then
            repeat
                avanca()
                if(not expr())then
                    return false
                end
                avanca()
            until (TK.texto ~= ",")
            return(TK.texto == ")")
        end
        
        recua()
        return true -- lambda
    end
    
    --trecho 21
    if (TK.texto == "(")then
        avanca()
        if(not expr()) then
            return false
        end
        avanca()
        return (TK.texto == ")")
    end
    
    if (TK.texto == "not") then
        avanca()
        return factor()
    end
    
    if (TK.texto == "[") then
        avanca()
        if(TK.texto == "]") then
            return true
        end
        return trecho22()
    end
  
    
    return false
end

function trecho22()
    if (expr()) then
        avanca()
        if(TK.texto == "..") then
            avanca()
            if(not expr()) then
                return false
            end
            avanca()
            if(TK.texto == ",")then
                avanca()
                return trecho22()
            end
            return (TK.texto == "]")
        end
    end
    return false
end

function term()
    --trecho 23
    if(not factor()) then
        return false
    end
    avanca()
    if(TK.texto ~= "*" and TK.texto ~= "/" and TK.texto ~= "div" and TK.texto ~= "mod" and TK.texto == "and") then
      return true
    end
    while(TK.texto == "*" or TK.texto == "/" or TK.texto == "div" or TK.texto == "mod" or TK.texto == "and") do
        avanca()
        if(not factor()) then
            return false
        end
        avanca()
    end
    recua()
    return true
end

function siexpr()
    --trecho 24
    if(TK.texto == "+" or TK.texto == "-") then
        avanca()
    end
    if(not term())then
        return false
    end
    avanca()
    if(TK.texto ~= "+" and TK.texto ~= "-" and  TK.texto == "or")then
      return true
    end
    while (TK.texto == "+" or TK.texto == "-" or  TK.texto == "or") do
        avanca()
        if(not term())then
            return false
        end
        avanca()
    end
    
    recua()
    return true
end

function expr()
    --trecho 25
    print("")
    if (not siexpr()) then
        return false
    end
    avanca()
    if(TK.tipo == "operador") then
        avanca()
        return siexpr()
    end
    recua()
    return true
end

function block()
    --trecho 26
    if(TK.texto == "label")then
          repeat
              avanca()
              if(TK.tipo ~= "numero")then
                  return false
              end
              avanca()
          until TK.texto ~= ","
          if (TK.texto ~= ";")then
              return false
          end
          avanca()
    end
    
    --trecho 27
    if(const())then
        avanca()
        if (TK.tipo ~= "identificador") then
            return false
        end
        repeat 
            determina(TK.texto, "COIDEN" )
            avanca()
            if(TK.texto ~= "=") then
                return false
            end
            avanca()
            if(not const()) then
                return false
            end
            avanca()
            if(TK.texto ~= ";")then
                return false
            end
            avanca()
        until TK.type ~= "identificador"
    end
    
    --trecho 28
    if(TK.texto == "type") then
        avanca()
        if(TK.tipo~= "identificador" )then
            return false
        end
        repeat
            determina(TK.texto,"TYIDEN")
            if (TK.texto ~= "=")then
                return false
            end
            avanca()
            if (not tipo())then
                return false
            end    
            avanca()
            if (TK.texto ~= ";")then
                return false
            end
            avanca()
        until (TK.tipo ~= "identificador")
    end
    
    --trecho 29
    if(TK.texto == "var")then
        avanca()
        if(TK.tipo ~= "identificador") then
            return false
        end
        determina(TK.texto,"VAIDEN")
        avanca()
        return trecho30()
    end
    return trecho31()
end

function trecho30()
    if(TK.texto == ",")then
        avanca()
        if(TK.tipo~="identificador") then
            return false
        end
        determina(TK.texto,"VAIDEN")
        avanca()
        return trecho30()
    end
      
    if(TK.texto == ":") then
        avanca()
        
        if (not tipo())then
            return false
        end
        avanca()
        if (TK.texto ~= ";")then
            return false
        end
        avanca()
        if(TK.tipo == "identificador") then
            determina(TK.texto,"VAIDEN")
            avanca()
            return trecho30()
        end
        return trecho31()
    end
end

function trecho31()
    if(TK.texto == "proc")then
        avanca()
        if(TK.tipo ~="identificador")then
            return false
        end
        determina(TK.texto,"PRIDEN")
        avanca()
        if(not palist())then
            return false
        end
        avanca()
        if(TK.texto ~=";")then
            return false  
        end
        avanca()
        if(not block())then
            return false  
        end
        avanca()
        if(TK.texto == ";")then
            avanca()
            return trecho31()
        end
        return false
    end
    
    if(TK.texto == "func")then
        avanca()
        if(TK.tipo ~= "identificador")then
            return false  
        end
        determina(TK.texto,"FUIDEN")
        avanca()
        if(not palist)then
            return false  
        end
        avanca()
        if(TK.texto ~= ":")then
            return false  
        end
        avanca()
        if(TK.tipo ~="identificador")then --TYIDEN
            return false  
        end
        avanca()
        if(TK.texto ~=";")then
            return false  
        end
        avanca()
        if(not block())then
            return false  
        end
        avanca()
        if(TK.tipo ~= ";")then
            return false  
        end
        avanca()
        return trecho31()
    end
    
    if(TK.texto == "begin")then
        repeat
            avanca()
            if(not statm())then
                return false  
            end
            avanca()
        until (TK.texto ~= ";")
        return TK.texto == "end"
    end
    return false
end

function palist() 
    --trecho 32
    if(TK.texto == "(") then
        avanca()
        return trecho33()
    end
  
    return true
end

function trecho33()
    if(TK.texto == "proc")then
        repeat
            avanca()
            if(TK.tipo ~= "identificador" )then
                return false
            end
            avanca()
        until  TK.tipo ~= ","
        if (TK.texto == ";")then
            avanca()
            return trecho33()
        end
            return TK.texto == ")"
        
    end
    
    if(TK.texto == "func" or TK.texto == "var")then
        avanca()
    end  
    if(TK.tipo ~= "identificador")then
        return false
    end
    avanca()
    while(Tk.texto==".")do
        avanca()
        if(TK.tipo ~= tipo) then
            return false
        end
        avanca()
    end
    if(TK.texto ~= ":") then
        return false
    end
    if(TK.tipo ~= "identificador")then --TYIDEN
        return false
    end
    
    if (TK.texto == ";")then
        avanca()
        return trecho33()
    end
    return TK.texto == ")"
end

function statm()
      --trecho 34
      if(TK.tipo == "numero")then
          avanca()
          if(TK.texto ~= ":")then
              return false
          end
          avanca()
      end
      
      --trecho 35
      if (TK.tipo == "identificador") then --VAIDEN
          avanca()
          if (not infipo()) then
              return false
          end
          avanca()
          if(TK.texto ~= ":=") then
              return false
          end
          avanca()
          return expr()
      
      --trecho 36
      elseif (TK.tipo == "identificador") then -- FUIDEN
          avanca()
          if(TK.texto ~= ":=") then
              return false
          end
          avanca()
          return expr()
          
      --trecho 37
      elseif (TK.tipo == "identificador") then -- PRIDEN
      avanca()
      if(TK.texto == "(")then
          repeat
          avanca()
          if (TK.tipo ~= "identificador")then --PRIDEN
              if (not expr()) then
                  return false
              end
          end
          avanca()
          until TK.texto ~= ","
          return TK.texto == ")"
       end
      
      recua()
      return true
      
      --trecho 38
      elseif (TK.texto == "begin") then
          repeat
              avanca()
              if(not statm())then
                  return false
              end
              avanca()
          until TK.texto ~= ";"
          return TK.texto == "end"
      
      --trecho 39
      elseif (TK.texto == "if") then
          avanca()
          if (not expr() )then 
              return false
          end
          avanca()
          if (TK.texto ~= "then")then 
              return false
          end
          avanca()
          if (not statm())then 
              return false
          end
          avanca()
          if (TK.tipo == "else")then 
              avanca()
              if (not statm())then 
                  return false
              end
              avanca()
          end
          recua()
          return true
          
      --trecho 40
      elseif (TK.texto == "case") then
          avanca()
          if (not expr())then 
              return false
          end
          avanca()
          if (TK.texto ~= " of" )then 
              return false
          end
          repeat
          repeat
              avanca()
              if(TK.tipo == "string" or TK.tipo == "identificador" or TK.tipo == "numero")then -- COIDEN
                  avanca()
              elseif (TK.texto == "+" or TK.texto == "-") then
                  avanca()
                  if(TK.tipo == "identificador" or TK.tipo == "numero") then
                      avanca()
                  end
                    
              elseif(TK.tipo == "identificador" or TK.tipo == "numero") then
                    avanca()
              else
              end
          until TK.texto == ","
          
          if(TK.texto ~= ":")then
              return false
          end
          avanca()
          if(not statm())then
              return false
          end
          until TK.texto ~= ";"
          return TK.texto == "end"
          
        
      elseif (TK.texto == "repeat") then
          repeat
              avanca()
              if not statm() then
                  return false
              end
              avanca()
          until TK.texto ~= ";"
          if(TK.texto ~= "until") then
              return false
          end
          avanca()
          return expr()
          
      elseif (TK.texto == "while") then
          avanca()
          if (not expr()) then
              return false
          end
          avanca()
          if (TK.texto ~= "do")then
              return false
          end
          avanca()
          return statm()
          
      elseif (TK.texto == "for") then
          avanca()
          if (TK.tipo ~= "identificador") then --VAIDEN
              return false
          end  
          avanca()
          if (not infipo()) then
              return false
          end
          avanca()
          if (TK.texto ~= ":=")then
              return false
          end
          avanca()
          if (not expr())then
              return false
          end
          
          avanca()
          if (TK.texto ~= "to" and TK.texto ~= "downto")then
              return false
          end
          avanca()
          if (not expr())then
              return false
          end
          avanca()
          if (TK.texto ~= "do")then
              return false
          end
          avanca()
          return statm()
          
      elseif (TK.texto == "with") then
          repeat 
              avanca()
              if (TK.texto ~= "identificador")then --VAIDEN
                  return false
              end
              avanca()
              if (not infipo())then
                  return false
              end
              avanca()
          until TK.texto ~= ","
          
          if (TK.texto ~= "do")then
              return statm()
          end
          
      elseif (TK.texto == "goto") then
          return TK.tipo == "numero"
      end
      
      recua()
      return true
end

function progrm()
    if (TK.texto ~= "program")then
        return false
    end
    avanca()
    if (TK.tipo ~= "identificador")then
        return false
    end
    avanca()
    if (TK.texto ~= "(")then
        return false
    end
    repeat
    avanca()
    if (TK.tipo ~= "identificador")then
        return false
    end
    avanca()
    until TK.texto ~= ","
    
    if (TK.texto ~= ")")then
        return false
    end
    avanca()
    if (TK.texto ~= ";")then
        return false
    end
    avanca()
    if (not block())then
        return false
    end
    avanca()
    return TK.texto == "."
end

if lexico(true) then
    main()
end