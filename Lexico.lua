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
lexdebug = false
lexicoOk = true

function analisa(palavra)
  len = palavra:len()
  posW = 1
  c = palavra:sub(posW,posW)
  while posW <= len do
    estadoInicial()
  end
end

function anda()
  posW = posW + 1
  c = palavra:sub(posW,posW)
  colunaNoCodigo = colunaNoCodigo + 1
end

function volta()
  posW = posW - 1
  c = palavra:sub(posW,posW)
  colunaNoCodigo = colunaNoCodigo - 1
end

function salvaToken(bufferDoToken, tipoDoToken)
  contadorTokens = contadorTokens + 1
  token[contadorTokens]={
      texto = bufferDoToken,
      tipo = tipoDoToken,
      linha = linhaNoCodigo,
      coluna = colunaNoCodigo,
      erro = false
  }
end

function salvaTokenComErro(bufferDoToken, tipoDoToken, erroDoToken)
  contadorTokens = contadorTokens + 1
  token[contadorTokens]={
      texto = bufferDoToken,
      tipo = tipoDoToken,
      linha = linhaNoCodigo,
      coluna = colunaNoCodigo,
      erro = erroDoToken
  }
end

function verificaErros()
    local i=1
    while (i<=contadorTokens)do
        if token[i].erro then
            lexicoOk = false
            logErro(i)
        end
        i = i+1
    end
end

function logErro(i)
    print("[ERRO]",token[i].erro,"linha",token[i].linha,"coluna",token[i].coluna)
end

function log()
  if(lexdebug) then
    print(contadorTokens,token[contadorTokens].texto,token[contadorTokens].tipo,token[contadorTokens].erro,"\n")
  end
end

function round(x)
  if x%2 ~= 0.5 then
    return math.floor(x+0.5)
  end
  return x-0.5
end

function buscaBinaria(buffer,i,j)
    m = math.floor( (i+j)/2) 
    if buffer == tabelaPalavras[m] then
        return true
    end
    if i>=j then
        return false
    end
    if buffer < tabelaPalavras[m] then
        return buscaBinaria(buffer,i,m-1)
    else
        return buscaBinaria(buffer,m+1,j)
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
    estadoOcta()
  elseif isPorcento(c) then
    estadoBinario()
  elseif isSifrao(c) then
    estadoHexa()
  elseif isPV(c) then
    estadoPV()
  elseif isDP(c) then
    estadoDP()
  elseif isMenos(c) then
    estadoMenos()
  elseif isAritmetico(c) then
    estadoAritimetico()
  elseif isAlpha(c) then
    estadoIdentificador()
  elseif isAspa(c) then
    estadoAspa()
  elseif isAspas(c) then
    estadoAspas()
  elseif isAChave(c) then
    estadoAChave()
  elseif isAParente(c) then
    estadoAParente()
  elseif isAColchete(c) then
    estadoAColchete()
  elseif isBChave(c) then
    estadoBChave()
  elseif isPonto(c) then
    estadoPonto()
  elseif isBParente(c) then
    estadoBParente()
  elseif isBColchete(c) then
    estadoBColchete()
  elseif isVirgula(c) then
    estadoVirgula()
  elseif isDec(c) then
    estadoNumero()
  end
end

function estadoMenor()
  buffer = c
  anda()
  if isMaior(c) then 
    buffer = buffer .. c
    salvaToken(buffer,"diferente")
    log()
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
    bueffer = buffer .. c
    salvaToken(buffer,"maiorIgual")
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

  if isIgual(c) then
    buffer = buffer .. c
    salvaToken(buffer,"atribuição")
    anda()
    log()
    return 1
  end
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
  buffer = buffer..c
  anda()
  buffer = buffer..c
  if isAspa(c) then
      anda()
      salvaToken(buffer,"caracter")
      log()
      return 1
  else
      anda()
      salvaTokenComErro(buffer,"caracter"," ' expected")
      log()
  end
end

function estadoAspas()
  buffer = c
  anda()
  while not isAspas(c) and c~="" do
      buffer = buffer .. c
      anda()
  end
  if isAspas(c) then 
      buffer = buffer .. c
      anda()
      salvaToken(buffer,"string")
      log()
      return 1
  else
      anda()
      salvaTokenComErro(buffer,"string", " '' expected")
      log()
      return 0
  end

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
  buffer = c
  anda()
  if(isPonto(c)) then
    buffer = buffer .. c
    salvaToken(buffer,"ponto ponto")
    anda()
    log()
    return 1
  end
  salvaToken(".","ponto")
  log()
  return 1
end

function estadoBColchete()
  buffer = c
  anda()
  salvaToken(buffer,"fecha colchete")
  log()
end

function estadoVirgula()
  buffer = c
  anda()
  salvaToken(buffer,"virgula")
  log()
end

function estadoBParente()
  buffer = c
  anda()
  salvaToken(buffer,"fecha parente")
  log()
end

function estadoBinario()
  buffer = c
  anda()
  while isBin(c) do
    buffer = buffer .. c
    anda()
  end
  if isColado(c) then
    salvaToken(buffer,"numero binario")
    log()
    return 1;
  end
  if(c ~= "") then
    salvaTokenComErro(buffer, "numero binario", "não há somente binarios")
    anda()
    log()
    return 0;
  else
    salvaToken(buffer,"numero binario")
    anda()
    log()
    return 1;
  end
end

function estadoOcta() 
  buffer = c
  anda()
  while isOcta(c) do
    buffer = buffer .. c
    anda()
  end
  if(c ~= "") then
    salvaTokenComErro(buffer, "numero octa","não há somente numeros octa")
    anda()
    log()
    return 1
  else
    salvaToken(buffer,"numero octa")
    anda()
    log() 
    return 0
  end
end

function estadoHexa()
  buffer = c
  anda()
  while isHexa(c) do
    buffer = buffer .. c
    anda()
  end
  if(c ~= "") then
    salvaTokenComErro(buffer,"numero hexa", "não há somente numeros hexa")
    anda()
    log()
    return 1
  else
    salvaToken(buffer,"numero hexa")
    anda()
    log()
    return 0;
  end
end

function estadoNumero()
  buffer = c
  anda()
  while isDec(c) do
    buffer = buffer .. c
    anda()
  end
  if isPonto(c) then
    anda()
    if(isPonto(c)) then
      salvaToken(buffer,"numero")
      log()
      salvaToken("..","ponto ponto")
      log()
      anda()
      return 2
    end
    if isDec(c) then
      volta()
      buffer = buffer .. c
      anda()
      while isDec(c) do
        buffer = buffer .. c
        anda()
      end  
      if isColado(c) then
        salvaToken(buffer,"float")
        log()
        return 1
      end
      if(c ~= "") then
        salvaTokenComErro(buffer,"float","não há somente numeros")
        anda()
        log()
        return 1
      else
        salvaToken(buffer,"float")
        anda()
        log()
        return 1
      end
    end
  end
  if isColado(c) then
    salvaToken(buffer,"numero")
    log()
    return 1;
  end

  if (c ~= "") then
    salvaTokenComErro(buffer,"numero", "não há somente numeros")
    anda()
    log()
    return 0;
  else
    salvaToken(buffer,"numero")
    anda()
    log()
    return 1;
  end

end

function estadoIdentificador()
  buffer = c
  anda()
  while isAlpha(c) or isDec(c) do--r isUnderLine() do
    buffer = buffer .. c
    anda()
  end
  if isColado(c) then
      if buscaBinaria(buffer:lower(),1,table.getn(tabelaPalavras)) then
          salvaToken(buffer:lower(),"reservada") 
      else
          salvaToken(buffer,"identificador") 
      end
      log()
      return 1
  end
  if(c ~= "") then
      salvaTokenComErro(buffer,"identificador", "simbolo não identificado")
      anda()
      log()
      return 0
  end
    
  if buscaBinaria(buffer:lower(),1,table.getn(tabelaPalavras)) then
        salvaToken(buffer:lower(),"reservada")
  else
        salvaToken(buffer,"identificador") 
  end
  log()
  return 1
end

function lexico(a)
  lexdebug = a
  leArquivo()
  for line in io.lines(file) do
    linhaNoCodigo = linhaNoCodigo + 1
    colunaNoCodigo = 1
    for word in string.gmatch(line, '[^ \n]+') do
      palavra = word
      analisa (palavra)
    end
  end
  verificaErros()
  return lexicoOk;
end

function leArquivo()
  file = 'pascal.txt'
  f = io.open(file, "rb")
  if f == nil then 
    print("deu ruim")
  end
end

table.sort(tabelaPalavras, function(a,b) return a<b end)
