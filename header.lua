tabelaPalavras ={"and", "array", "asm", "begin", "break", "case", "const", "constructor", "continue", "destructor", "div", "do", "downto","else", "end", "false", "file", "for", "function", "goto", "if", "implementation", "in", "inline", "interface", "label","mod", "nil", "not" , "object", "of", "on", "operator", "or" ,"packed", "procedure", "program", "record", "repeat", "set","shl", "shr", "string", "then", "to", "true", "type", "unit", "until", "uses", "var", "while", "with", "xor", "absolute","abstract", "alias", "assembler", "cdecl", "cppdecl", "default", "export", "external", "forward", "generic", "index","local", "name", "nostackframe", "oldfpccall", "override", "pascal", "private", "protected", "public", "published", "read","readln", "register", "reintroduce", "reset", "rewrite", "safecall", "softfloat", "specialize", "stdcall", "virtual","write", "writeln", "as", "class", "dispinterface", "except", "exports", "finalization", "finally", "initialization","inline", "is", "library", "on", "out", "property", "raise", "resourcestring", "threadvar", "try","byte","shortint","smallinte","word","integer","word","cardinal","longint","longword","int64","qword"}

function isAlpha(char)
    asc = string.byte(char)
    return asc == 65 or asc == 66 or asc == 67 or asc == 68 or asc == 69 or asc == 70 or asc == 71 or asc == 72 or asc == 73 or    asc == 74 or asc == 75 or asc == 76 or asc == 77 or asc == 78 or asc == 79 or asc == 80 or asc == 81 or asc == 82 or asc == 83 or asc == 84 or asc == 85 or asc == 86 or asc == 87 or asc == 88 or asc == 89 or asc == 90 or asc == 97 or asc == 98 or asc == 99 or asc == 100 or asc == 101 or asc == 102 or asc == 103 or          asc == 104 or asc == 105 or asc == 106 or asc == 107 or asc == 108 or asc == 109 or asc == 110 or asc == 111 or asc == 112 or     asc == 113 or asc == 114 or asc == 115 or asc == 116 or asc == 117 or asc == 118 or asc == 119 or asc == 120 or asc == 121 or     asc == 122
end

function isBin(char)
  if(char) then
      asc = string.byte(char)
      return (asc == 48 or asc == 49)
  end
  return false
end
    
function isOcta(char)
      asc = string.byte(char)
      return (asc == 48 or asc == 49 or asc == 50 or asc == 51 or asc == 52 or asc == 53 or asc == 54 or asc==55)
end

function isDec(char)
        asc = string.byte(char)
        return (asc == 48 or asc == 49 or asc == 50 or asc == 51 or asc == 52 or asc == 53 or asc == 54 or asc == 55 or asc == 56 or  asc == 57)
end

function isHexa(char)
        asc = string.byte(char)
        return (asc == 48 or asc == 49 or asc == 50 or asc == 51 or asc == 52  or asc == 53 or asc == 54 or asc == 55 or asc == 56 or asc == 57 or asc == 65 or asc == 66 or asc == 67 or asc == 68 or asc == 69 or asc == 70 or asc == 97 or asc == 98 or asc == 99 or asc == 100  or asc == 101 or asc == 102)
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
    if(char == nil) then return false else
    asc = string.byte(char)
    end
    return asc == 38
end

function isUnderLine(char)
    asc = string.byte(char)
    return asc == 95
end

function identificador(char)
    return isAlpha(char) or isUnderLine(char) or isDec(char)
end  

function isColado(char)
  return isAritmetico(char) or isMenos(char) or isMenor(char) or isMaior(char) or isIgual(char) or isPV(char) or isDP(char) or isVirgula(char) or isAParente(char) or c==nil or isAColchete(char) or isBParente(char) or isBColchete(char) or isPonto(char)
end  