function isAlpha(char)
  asc = string.byte(char)
  return (asc >= 65 and asc <=90) or (asc>=97 and asc<=122)
end

function isBin(char)
  asc = string.byte(char)
  return (asc == 48 or asc == 49)
end
    
function isOcta(char)
  asc = string.byte(char)
  return (asc >= 48 and asc<=55)
end

function isDec(char)  
    asc = string.byte(char)
    return (asc >= 48 and asc <= 57)
end

function isHexa(char)
    asc = string.byte(char)
    return (asc >= 48 and asc <= 57) or (asc >= 65 and asc <= 70) or (asc >= 97 and asc <= 102)
end

function isAritmetico(char)
    asc = string.byte(char)
    return asc == 42 or asc == 43 or asc == 47
end

function isMenos(char)
    asc = string.byte(char)
    return asc == 45
end

function isMaior(char)
    asc = string.byte(char)
    return asc == 62
end

function isMenor(char)
    asc = string.byte(char)
    return asc == 60
end

function isIgual(char)
    asc = string.byte(char)
    return asc == 61
end

function isDP(char)
    asc = string.byte(char)
    return asc == 58
end

function isPV(char)
    asc = string.byte(char)
    return asc == 59
end

function isPonto(char)
    asc = string.byte(char)
    return asc == 46
end

function isVirgula(char)
    asc = string.byte(char)
    return asc == 44
end  

function isSifrao(char)
    asc = string.byte(char)
    return asc == 36
end

function isPorcento(char)
    asc = string.byte(char)
    return asc == 37
end

function isAspa(char)
    asc = string.byte(char) 
    return asc == 39
end

function isAspas(char)
    asc = string.byte(char) 
    return asc == 34
end

function isAChave(char)
    asc = string.byte(char)
    return asc == 123
end

function isBChave(char)
    asc = string.byte(char)
    return asc == 125
end

function isAParente(char)
    asc = string.byte(char)
    return asc == 40
end

function isBParente(char)
    asc = string.byte(char)
    return asc == 41
end

function isAColchete(char)
    asc = string.byte(char)
    return asc == 91
end

function isBColchete(char)
    asc = string.byte(char)
    return asc == 93
end

function isComercial(char)
    asc = string.byte(char)
    return asc == 38
end

function isUnderLine(char)
    asc = string.byte(char)
    return asc == 95
end

function identificador(char)
    return isAlpha(char) or isUnderLine(char) or isDec(char)
end  

function colado(char)
  return isAritmetico(char) or isMenos(char) or isMenor(char) or isMaior(char) or isIgual(char) or isPV(char)       or isDP(char) or isVirgula(char) or isAParente(char)
end  