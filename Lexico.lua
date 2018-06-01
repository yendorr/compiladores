require "header"
local file
local linhaNoCodigo = 0
local colunaNoCodigo = 0
var := posW=1
local buffer
local token={}
local contadorTokens = 0
local len
c=nil
local palavra

function analisa(palavra)
    len = palavra:len()
    posW = 1
    c = palavra:sub(posW,posW)
    while posW <= len do
        estadoInicial(c)
    end
end

function estadoInicial(c)
        
    if isMaior(c) then
        estadoMaior(c)
    elseif isMenor(c) then
        estadoMenor(c)
    elseif isIgual(c) then
    
    elseif isComercial(c) then
    
    elseif isPorcento(c) then
    
    elseif isSifrao(c) then
    
    elseif isPV(c) then
          
    elseif isDP(c) then
      
    elseif isMenos(c) then
    
    elseif isAritmetico(c) then
          
    elseif isAlpha(c) then
    
    elseif isAspa(c) then
  
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

function estadoMenor(c)
    buffer = c
    posW = posW + 1
    c = palavra:sub(posW,posW)
    
    if isMaior(c) then --and i<=len then
        buffer = buffer .. c
        --salva operador diferente
        
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

function estadoMaior(c)
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

function estadoIgual(c)
  
  contadorTokens = contadorTokens + 1
  token[contadorTokens]={
    texto = buffer,
    tipo = "igual",
    linha = linhaNoCodigo,
    coluna = colunaNoCodigo,
    contadorErros = 0,
    erro = {}
  }
  print(contadorTokens,"diferente",token)
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