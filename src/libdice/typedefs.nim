type
  TokenKind* = enum
    tkNumber, tkDiceD, tkMultiply, tkDivide, tkAdd, tkSubtract, tkLeftParen, tkRightParen, tkUnknown
  Token* = object
    kind*: TokenKind
    value*: string
  Dice* = object
    count*: int
    sides*: int
