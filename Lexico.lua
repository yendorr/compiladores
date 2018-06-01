require "header"
file = nil
linhaNoCodigo = 0
colunaNoCodigo = 0
posW = 0
buffer = nil
token={}
contadorTokens = 0
len=0
c = nil;
palavra = nil

function analisa(palavra)
    len = palavra:len()
    posW = 1
    c = palavra:sub(posW,posW)
    while posW <= len do
        estadoInicial()
    end
end

function anda()
    posW = posW+1
    c = palavra:sub(posW,posW)
    colunaNoCodigo = colunaNoCodigo + 1
end

function salvaToken(bufferDoToken, tipoDoToken)
  contadorTokens = contadorTokens + 1
  token[contadorTokens]={
      texto = bufferDoToken,
      tipo = tipoDoToken,
      linha = linhaNoCodigo,
      coluna = colunaNoCodigo,
      contadorErros = 0,
      erro = {}
  }
end

function log()
    print("palavra - c",palavra,c)
    print("pos - len",posW , len)
    print(contadorTokens,token[contadorTokens].texto,"\n")
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
        estadoAritimetico()
    elseif isAlpha(c) then
        
    elseif isAspa(c) then
        estadoAspa()
    elseif isAspas(c) then
        estadoAspas()
    elseif isAChave(c) then
        estadoAChave()
    elseif isAParente(c) then
        estadoAparente()
    elseif isAColchete(c) then
        estadoAColchete()
    elseif isBChave(c) then
        estadoBChave()
    elseif isPonto(c) then
        estadoPonto()
    elseif isBParente(c) then
        estadoBParente()
    elseif isBColchete(c) then
        estadoBcolchete()
    elseif isDec(c) then
         
    end
end

function estadoMenor()
    buffer = c
    anda()
    if isMaior(c) then 
        buffer = buffer .. c
        
        
        salvaToken(buffer,"diferente")
        
        anda()
        return 1
        
    elseif isIgual(c) then --and i<=len then
        buffer = buffer .. c
        
        salvaToken(buffer,"menorIgual")
        
        log()
        anda()
        return 1
    else
        salvaToken(buffer,"menor")
        log()
        return 1
    end
end

function estadoMaior()
    buffer = c
    anda()
    
    if isIgual(c) then
        salvaToken(buffer,"menorIgual")
        log()
        anda()
        return 1
    else    
        salvaToken(buffer,"maior")
        log()
        return 1;
    end
end

function estadoIgual()  
    buffer = c
    anda()
    if(isIgual(c)) then
        buffer = buffer .. c
        salvaToken(buffer,"igual")
        log()
        anda()
        return 1
    end
    salvaToken(buffer,"atribuicao")
    log()
    return 1
end

function estadoPV()
    buffer = c
    anda()
    salvaToken(buffer,"pontoVirgula")
    log()
    return 1
end

function estadoDP()
    buffer = c
    anda()
    salvaToken(buffer,"doisPontos")
    log()
    return 1
end

function estadoMenos()
    buffer = c
    anda()
    salvaToken(buffer,"menos")
    log()
    return 1
end

function estadoAritimetico()
    buffer = c
    anda()
    salvaToken(buffer,"aritmetico")
    log()
    return 1
end

function estadoAspa()
    buffer = c
    anda()
    salvaToken(buffer,"aspa")
    log()
    return 1
end

function estadoAspas()
    buffer = c
    anda()
    salvaToken(buffer,"aspas")
    log()
    return 1
end

function estadoAChave()
    buffer = c
    anda()
    salvaToken(buffer,"abreChave")
    log()
    return 1
end
function estadoAParente()
    buffer = c
    anda()
    salvaToken(buffer,"abreParente")
    log()
    return 1
end

function estadoAColchete()
    buffer = c
    anda()
    salvaToken(buffer,"abreColchete")
    log()
    return 1
end

function estadoBChave()
    buffer = c
    anda()
    salvaToken(buffer,"abre colchete")
    log()
    return 1
end

function estadoPonto()
    
end
        
function estadoBParente()
    
end

function estadoBColchete()
  
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