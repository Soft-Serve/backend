module Result
  class Base
    def self.merge(results)
      if results.all?(&:successful?)
        Result::Ok.new(results.map(&:value))
      else
        failed_results = results
          .reject(&:successful?)

        errors = failed_results
          .reduce({}) do |memo, result|
            memo.merge(result.errors) do |_k, old, new|
              old | new
            end
          end

        Result::Error.new(
          errors,
          exception: failed_results.map(&:exception).compact.first
        )
      end
    end

    def unwrap!
      raise NotImplementedError
    end

    def when_ok(&block)
      raise NotImplementedError
    end

    def bind(&block)
      raise NotImplementedError
    end
  end
end