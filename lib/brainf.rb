module BrainF
  class Interpreter
    INVALID_INSTRUCTION        = /[^<>+-.,\[\]]/
    MIN_BYTE_VAL, MAX_BYTE_VAL = 0, 255
    MIN_ADDRESS, MAX_ADDRESS   = 0, 30000
    
    def eval(input)
      @instructions = input.gsub INVALID_INSTRUCTION, ''
      @data         = (MIN_ADDRESS...MAX_ADDRESS).map { 0 }
      @iptr, @dptr  = MIN_ADDRESS, MIN_ADDRESS
      @stack        = []
      
      while @iptr < @instructions.size
        case @instructions[@iptr]
        when '>'
          incr_dptr
        when '<'
          decr_dptr
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
      
      true
    end
    
    private
    
    def byte
      @data[@dptr]
    end
    
    def instruction
      @instructions[@iptr]
    end
    
    def incr_iptr
      @iptr += 1
    end
    
    def decr_iptr
      @iptr -= 1
    end
    
    def incr_dptr
      @dptr += 1
    end
    
    def decr_dptr
      @dptr -= 1
    end
    
    def incr_byte
      @data[@dptr] += 1
      @data[@dptr] = MIN_BYTE_VAL if byte > MAX_BYTE_VAL
    end
    
    def decr_byte
      @data[@dptr] -= 1
      @data[@dptr] = MAX_BYTE_VAL if byte < MIN_BYTE_VAL
    end
    
    def output_byte
      $stdout.print byte.chr
    end
    
    def accept_byte
      @data[@dptr] = $stdin.getc.ord unless $stdin.eof?
    end
    
    def jump_forward
      return unless byte == MIN_BYTE_VAL
      
      @stack.push '['
      until @stack.empty?
        incr_iptr
        @stack.push '[' if instruction == '['
        @stack.pop      if instruction == ']'
      end
    end
    
    def jump_back
      return if byte == MIN_BYTE_VAL
      
      @stack.push ']'
      until @stack.empty?
        decr_iptr
        @stack.push ']' if instruction == ']'
        @stack.pop      if instruction == '['
      end
    end
  end
end
