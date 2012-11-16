require 'io/console'

module BrainF
  class Interpreter    
    def eval(input)
      @instructions = input
      @data         = (1..30000).map { 0 }
      @iptr, @dptr  = 0, 0
      @stack        = []
      
      while @iptr < @instructions.size
        case @instructions[@iptr]
        when '>'
          incr_ptr
        when '<'
          decr_ptr
        when '+'
          incr_byte
        when '-'
          decr_byte
        when '.'
          output_byte
        when ','
          accept_byte
        when '['
          jump_forward
        when ']'
          jump_back
        end
        
        @iptr += 1
      end
      
      @data.map(&:chr).join('')
    end
    
    private
    
    def incr_ptr
      @dptr += 1
    end
    
    def decr_ptr
      @dptr -= 1
    end
    
    def incr_byte
      @data[@dptr] += 1
    end
    
    def decr_byte
      @data[@dptr] -= 1
    end
    
    def output_byte
      print @data[@dptr].chr
    end
    
    def accept_byte
      @data[@dptr] = STDIN.getch.ord
    end
    
    def jump_forward
      return if @data[@dptr] != 0
      
      @stack.push '['
      while !@stack.empty?
        @iptr += 1
        @stack.push '[' if @instructions[@iptr] == '['
        @stack.pop      if @instructions[@iptr] == ']'
      end
    end
    
    def jump_back
      return if @data[@dptr] == 0
      
      @stack.push ']'
      while !@stack.empty?
        @iptr -= 1
        @stack.push ']' if @instructions[@iptr] == ']'
        @stack.pop      if @instructions[@iptr] == '['
      end
    end
  end
end
