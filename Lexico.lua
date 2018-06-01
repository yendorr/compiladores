require "header"
local file
local linhaNoCodigo = 0
local colunaNoCodigo = 0
posW = 0
local buffer
local token={}
local contadorTokens = 0
local len
c=nil;
local palavra

function analisa(palavra)
    len = palavra:len()
    posW = 1
    c = palavra:sub(posW,posW)
    while posW <= len do
        estadoInicial()
    end
end

function estadoInicial()
        
    if isMaior(c) then
        estadoMaior()
    elseif isMenor(c) then
        estadoMenor()
    elseif isIgual(c) then
        estadoIgual()
    elseif isComercial(c) then
    
    elseif isPorcento(c) then
    
    elseif isSifrao(c) then
    
    elseif isPV(c) then
        estadoPV()
    elseif isDP(c) then
        estadoDP()
    elseif isMenos(c) then
        estadoMenos()
    elseif isAritmetico(c) then
          
    elseif isAlpha(c) then
    
    elseif isAspa(c) then
        estadoAspa()
    elseif isAspas(c) then
        
    elseif isAChave(c) then
  
    elseif isAParente(c) then
      
    elseif isAColchete(c) then
        
    elseif isBChave(c) then
      
    elseif isPonto(c) then
       
    elseif isBParente(c) then
        
    elseif isBColchete(c) then
        
    elseif isDec(c) then
         
    end
end

function estadoMenor()
    buffer = c
    posW = posW + 1
    c = palavra:sub(posW,posW)
    
    if isMaior(c) then 
        buffer = buffer .. c
        
        contadorTokens = contadorTokens + 1
        token[contadorTokens]={
            texto = buffer,
            tipo = "diferente",
            linha = linhaNoCodigo,
            coluna = colunaNoCodigo,
            contadorErros = 0,
            erro = {}
        }
        
        print("palavra - c",palavra,c)
        print("pos - len",posW , len)
        print(contadorTokens,"diferente",buffer,"\n")
        posW = posW + 1
        c = palavra:sub(posW,posW)
        return 1
        
    elseif isIgual(c) then --and i<=len then
        buffer = buffer .. c
        
        contadorTokens = contadorTokens + 1
        token[contadorTokens]={
            texto = buffer,
            tipo = "MenorIgual",
            linha = linhaNoCodigo,
            coluna = colunaNoCodigo,
            contadorErros = 0,
            erro = {}
        }
        
        print("palavra - c",palavra,c)
        print("pos - len",posW , len)
        print(contadorTokens,"menorIgual",buffer,"\n")
        posW = posW + 1
        c = palavra:sub(posW,posW)
        return 1
    else
        contadorTokens = contadorTokens + 1
        token[contadorTokens]={
            texto = buffer,
            tipo = "menor",
            linha = linhaNoCodigo,
            coluna = colunaNoCodigo,
            contadorErros = 0,
            erro = {}
        }
        
        print("palavra - c",palavra,c)
        print("pos - len",posW , len)
        print(contadorTokens,"menor",buffer,"\n")
        return 1
    end
end

function estadoMaior()
    buffer = c
    posW = posW + 1
    c = palavra:sub(posW,posW)
    
    if isIgual(c) then
        buffer = buffer..c
        contadorTokens = contadorTokens + 1
        token[contadorTokens]={
            texto = buffer,
            tipo = "maiorIgual",
            linha = linhaNoCodigo,
            coluna = colunaNoCodigo,
            contadorErros = 0,
            erro = {}
        }
        print("palavra - c",palavra,c)
        print("pos - len",posW , len)
        print(contadorTokens,"maiorIgual",buffer,"\n")
        posW = posW + 1
        c = palavra:sub(posW,posW)
        return 1
    else    
        contadorTokens = contadorTokens + 1
        token[contadorTokens]={
            texto = buffer,
            tipo = "maior",
            linha = linhaNoCodigo,
            coluna = colunaNoCodigo,
            contadorErros = 0,
            erro = {}
        }
        print("palavra - c",palavra,c)
        print("pos - len",posW , len)
        print(contadorTokens,"maior",buffer,"\n")        
        return 1;
    end
end

function estadoIgual()  
    buffer = c
    posW = posW+1
    c = palavra:sub(posW,posW)
    if(isIgual(c)) then
        buffer = buffer .. c
        contadorTokens = contadorTokens + 1
        token[contadorTokens]={
            texto = buffer,
            tipo = "igual",
            linha = linhaNoCodigo,
            coluna = colunaNoCodigo,
            contadorErros = 0,
            erro = {}
        }
        print("palavra - c",palavra,c)
        print("pos - len",posW , len)
        print(contadorTokens,"igual",buffer,"\n")
        posW = posW+1
        c = palavra:sub(posW,posW)
        return 1
    end
    contadorTokens = contadorTokens + 1
    token[contadorTokens]={
        texto = buffer,
        tipo = "atr",
        linha = linhaNoCodigo,
        coluna = colunaNoCodigo,
        contadorErros = 0,
        erro = {}
    }
    print("palavra - c",palavra,c)
    print("pos - len",posW , len)
    print(contadorTokens,"atribuição",buffer,"\n")
    return 1
end

function estadoPV()
    buffer = c
    posW = posW+1
    c = palavra:sub(posW,posW)
    contadorTokens = contadorTokens + 1
    token[contadorTokens]={
        texto = buffer,
        tipo = "PontoVirgula",
        linha = linhaNoCodigo,
        coluna = colunaNoCodigo,
        contadorErros = 0,
        erro = {}
    }
    print("palavra - c",palavra,c)
    print("pos - len",posW , len)
    print(contadorTokens,"PV",buffer,"\n")
    return 1
end

function estadoDP()
    buffer = c
    posW = posW+1
    c = palavra:sub(posW,posW)
    contadorTokens = contadorTokens + 1
    token[contadorTokens]={
        texto = buffer,
        tipo = "DoisPontos",
        linha = linhaNoCodigo,
        coluna = colunaNoCodigo,
        contadorErros = 0,
        erro = {}
    }
    print("palavra - c",palavra,c)
    print("pos - len",posW , len)
    print(contadorTokens,"DP",buffer,"\n")
    return 1
end

function estadoMenos()
    buffer = c
    posW = posW+1
    c = palavra:sub(posW,posW)
    contadorTokens = contadorTokens + 1
    token[contadorTokens]={
        texto = buffer,
        tipo = "menos",
        linha = linhaNoCodigo,
        coluna = colunaNoCodigo,
        contadorErros = 0,
        erro = {}
    }
    print("palavra - c",palavra,c)
    print("pos - len",posW , len)
    print(contadorTokens,"menos",buffer,"\n")
    return 1
end

function estadoAspa()
    buffer = c
    posW = posW+1
    c = palavra:sub(posW,posW)
    contadorTokens = contadorTokens + 1
    token[contadorTokens]={
        texto = buffer,
        tipo = "aspa",
        linha = linhaNoCodigo,
        coluna = colunaNoCodigo,
        contadorErros = 0,
        erro = {}
    }
    print("palavra - c",palavra,c)
    print("pos - len",posW , len)
    print(contadorTokens,"aspa",buffer,"\n")
    return 1
end

function main()
    leArquivo()
    for line in io.lines(file) do
        linhaNoCodigo = linhaNoCodigo + 1
        colunaNoCodigo = 1
        for word in string.gmatch(line, '[^ \n]+') do
            palavra = word
            analisa (palavra)
        end
    end
end

function leArquivo()
    file = 'pascal.txt'
    f = io.open(file, "rb")
    if f == nil then 
        print("deu ruim")
    end
end

main()