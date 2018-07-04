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
    print(TK.texto)
end

function main()
    print("--------------------------------------SS-------------------")
    avanca()
    print( TK.texto, tipo())
    avanca()
    print( TK.texto, tipo())
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
            if (const()) then
                return true
            end
        end
    end
    
    return false
end

function const()
    -- trecho 1
    if (TK.tipo == "string") then
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
    if (TK.texto==".")then
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
                print("ah meu")
                return false
            end
        else
            print("poxa", TK.texto)
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
                return trecho15()
            end
        end
    end
    recua()
    return true -- lambda
end

function trecho15()
    
    
end

if lexico(false) then
    main()
end