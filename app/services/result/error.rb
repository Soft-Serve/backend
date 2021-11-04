module Result
  class Error < Base
    attr_reader :errors, :exception

    def initialize(msg, exception: nil, type: nil)
      @exception = exception
      @errors = ErrorContainer.new(msg: msg, type: type)
    end

    def successful?
      false
    end

    def value
      nil
    end

    def bind(&_block)
      self
    end

    def when_ok(&block)
      self
    end

    # Yields the value to the given block and then return the current result.
    #
    # In case it is an ok it just returns the result instead.
    def when_err(&block)
      block.call(errors)

      self
    end
  end
end
