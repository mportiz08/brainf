require 'test/unit'
require 'stringio'

class String
  # Strip leading whitespace from each line that is the same as the 
  # amount of whitespace on the first line of the string.
  # Leaves _additional_ indentation on later lines intact.
  # 
  # from http://stackoverflow.com/a/5638187/94751
  def unindent
    gsub /^#{self[/\A\s*/]}/, ''
  end
  
  def as_one_line
    split("\n").join('')
  end
end

def mock_stdout(&block)
  orig_stdout = $stdout
  $stdout = StringIO.new
  yield
  $stdout = orig_stdout
end

def mock_stdin(input, &block)
  orig_stdin = $stdin
  $stdin = StringIO.new(input)
  yield
  $stdin = orig_stdin
end