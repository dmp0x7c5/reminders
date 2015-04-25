module Response
  class Base
    attr_accessor :data, :errors

    def initialize(data: nil, errors: [])
      self.data = data
      self.errors = errors
    end
  end
end
