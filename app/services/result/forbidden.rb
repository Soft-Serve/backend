module Result
  module Forbidden
    def self.new(msg = 'forbidden')
      Result::Error
        .new(
          { status: [msg] },
          type: :forbidden
        )
    end
  end
end
