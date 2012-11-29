require 'test/unit'
require 'stringio'

def mock_stdout(&block)
  orig_stdout = $stdout
  $stdout = StringIO.new
  yield
  $stdout = orig_stdout
end
