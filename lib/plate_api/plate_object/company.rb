require_relative "base"

module PlateApi::PlateObject
  class Company < Base

    def initialize(id, attributes, relations, object_handler=nil)
      super(id, attributes, relations, object_handler)
    end

    def self.api_name
      "companies"
    end
  end
end
