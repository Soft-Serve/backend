module Result
  class Ok < Base
    attr_reader :value

    def initialize(value)
      @value = value
    end

    def successful?
      true
    end

    def errors
      {}
    end

    def exception
      nil
    end

    def unwrap!
      value
    end

    # Implements the monadic bind method.
    # This allows you to chain result based
    # methods.
    def bind
      yield value
    end

    # Yields the value to the given block and then return the current result.
    #
    # In case it is an error it just returns the result instead.
    def when_ok(&block)
      block.call(value)

      self
    end

    def when_err(&block)
      self
    end
  end
end
