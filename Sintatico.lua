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

function main()
    print("--------------------------------------SS-------------------")
    avanca()
    print( TK.texto, term())
    avanca()
    print( TK.texto, term())
    --[[avanca()
    print( TK.texto, tipo())
    avanca()
    print( TK.texto, tipo())]]
    
    
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
end

function term()
    if(not factor()) then
        return false
    end
    avanca()
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

function expr()
    --trecho 
    if (not siexpr()) then
        return false
    end
    avanca()
    if(TK.tipo == "operador") then
        avanca()
        return siexpr()
    end
    
    return true
end



function siexpr()
    
end

if lexico(true) then
    main()
end