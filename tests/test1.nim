import unittest

import libdice
test "order of operations":
  check rollDiceExpression("5 + 4/2") == 7
