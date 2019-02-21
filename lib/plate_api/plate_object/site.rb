require_relative "base"

module PlateApi::PlateObject
  class Site < Base

    def initialize(id, attributes)
      raise ArgumentError.new("No `name` found in `attributes` for #new") if attributes["name"].to_s.empty?

      @id = id
      @attributes = attributes
    end

    def name
      @attributes["name"]
    end

    def update(attributes)
      
    end

    def api_name
      self.class.url_name
    end

    def self.api_name
      "sites"
    end
  end
end
