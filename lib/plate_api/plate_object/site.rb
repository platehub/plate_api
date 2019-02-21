require_relative "base"

module PlateApi::PlateObject
  class Site < Base

    def initialize(id, attributes, relations, object_handler=nil)
      raise ArgumentError.new("No `name` found in `attributes` for #new") if attributes["name"].to_s.empty?
      super(id, attributes, relations, object_handler)
    end

    def name
      @attributes["name"]
    end

    def update(attributes)
      raise ArgumentError.new("Input `attributes` is not a Hash") unless attributes.is_a? Hash
      raise ArgumentError.new("No object_handler is attached to this object") unless @object_handler
      new_site = @object_handler.update(@id, attributes)
      @attributes = new_site.attributes
    end

    def self.api_name
      "sites"
    end
  end
end
