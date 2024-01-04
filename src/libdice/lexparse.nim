import typedefs, strutils

iterator readDiceExpression*(str: string): Token =
  var lexeme: string = ""
  for c in str:
    template yieldAndReset(tkKind: TokenKind) =
      if lexeme != "":
        yield Token(kind: tkNumber, value: lexeme)
      lexeme = ""
      yield Token(kind: tkKind, value: $c)
    case c:
      of '0' .. '9': lexeme.add(c)
      of 'd', 'D': yieldAndReset(tkDiceD)
      of '+': yieldAndReset(tkAdd)
      of '-': yieldAndReset(tkSubtract)
      of '*': yieldAndReset(tkMultiply)
      of '/': yieldAndReset(tkDivide)
      of '(': yieldAndReset(tkLeftParen)
      of ')': yieldAndReset(tkRightParen)
      of Whitespace:
        if lexeme != "":
          yield Token(kind: tkNumber, value: lexeme)
          lexeme = ""
      else:
        yieldAndReset(tkUnknown)
  if lexeme != "":
    yield Token(kind: tkNumber, value: lexeme)

# shunting yard algorithm converts infix to postfix notation
proc shuntingYardDice*(expression: string): seq[Token] =
  var operatorStack: seq[Token] = @[]
  for tk in readDiceExpression(expression):
    case tk.kind:
      of tkNumber:
         result.add tk
      of tkDiceD, tkMultiply, tkDivide, tkAdd, tkSubtract:
        while operatorStack.len > 0 and operatorStack[^1].kind != tkLeftParen and operatorStack[^1].kind <= tk.kind:
          result.add operatorStack.pop
        operatorStack.add tk
      of tkLeftParen:
        operatorStack.add tk
      of tkRightParen:
        while operatorStack.len > 0 and operatorStack[^1].kind != tkLeftParen:
          result.add operatorStack.pop
        if operatorStack.len > 0 and operatorStack[^1].kind == tkLeftParen:
          operatorStack.pop
        else:
          return @[]
      of tkUnknown:
        return @[]
  while operatorStack.len > 0:
    result.add operatorStack.pop
