import typedefs, lexparse, strutils, math, random, sequtils

proc randomizeDice* = randomize()

proc rollDice*(dice: Dice): seq[int] =
  for i in 0 ..< dice.count:
    result.add(rand(1..dice.sides))

proc rollDiceExpression*(expression: string): int =
  var stack: seq[int] = @[]
  for tk in shuntingYardDice(expression):
    case tk.kind:
      of tkNumber:
        stack.add parseInt(tk.value)
      of tkDiceD:
        var dice: Dice
        dice.sides = stack.pop
        dice.count = stack.pop
        stack.add rollDice(dice).foldl(a + b)
      of tkMultiply:
        stack.add stack.pop * stack.pop
      of tkDivide:
        let divisor = stack.pop
        stack.add ceilDiv(stack.pop, divisor)
      of tkAdd:
        stack.add stack.pop + stack.pop
      of tkSubtract:
        let subtrahend = stack.pop
        stack.add stack.pop - subtrahend
      else:
        return -1
  if stack.len == 1:
    result = stack[0]
