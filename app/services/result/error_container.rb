module Result
  class ErrorContainer < SimpleDelegator
    ALLOWED_ERRORS = %i[
      forbidden
      default
    ].freeze
    DEFAULT_ERROR = :default

    def initialize(
      msg:,
      type: DEFAULT_ERROR
    )
      @type = type
      @msg = msg

      # TODO: remove this hack
      __setobj__(apply_default_array(msg))
    end

    def type
      return DEFAULT_ERROR unless @type.in?(ALLOWED_ERRORS)

      @type
    end

    def to_s
      values.flatten.join(', ')
    end

    private

    attr_reader :msg

    # Stolen from `ActiveModel::Error`.
    # Sets a default to an empty array for a given error key.
    def apply_default_array(hash)
      hash.default_proc = proc { |h, key| h[key] = [] }
      hash
    end
  end
end
