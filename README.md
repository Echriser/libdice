# Libdice
This is a library used for parsing and rolling dice notation as commonly seen in many TTRPGs (Tabletop Role Playing Games) such as Dungeons & Dragons, Pathfinder, Savage Worlds, and more!

⚠️ Please note: This library is currently very early, and the API is incomplete and unstable, expect bugs

# Usage
To roll a dice notation expression, you can use the `rollDiceExpression` function.

``` nim
echo rollDiceExpression("2d6 + 5")
```

# Planned
The following features are planned:
* Support for Fudge/Fate dice
* Support for Genesys dice
* Seeing the results of individual rolls
