require 'test_helper'
require 'brainf'

class TestBrainfInterpreter < Test::Unit::TestCase
  def setup
    @interpreter = BrainF::Interpreter.new
  end
  
  def test_hello_world
    test_interpreter '++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>.',
                     "Hello World!\n"
  end
  
  private
  
  def test_interpreter(input, expected_result)
    mock_stdout do
      @interpreter.eval(input)
      assert_equal expected_result, $stdout.string
    end
  end
end
