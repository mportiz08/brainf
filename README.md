# brainf

a simple [brain#!@$](http://www.muppetlabs.com/~breadbox/bf/) interpreter

# usage

    > bin/brainf '++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>.' 
    Hello World!
    
or programatically:

```ruby    
require 'brainf'

program = '++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>.'
interpreter = BrainF::Interpreter.new
interpreter.eval(input)
```
