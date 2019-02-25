require_relative "base"
require_relative "company"

module PlateApi::PlateObject
  class Site < Base

    attr_accessor :theme_id, :company_id

    def initialize(id, attributes, relations, object_handler=nil)
      raise ArgumentError.new("No `name` found in `attributes` for #new") if attributes["name"].to_s.empty?
      @theme_id = relations["theme_id"]
      @company_id = relations["company_id"]
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

    def theme
      @theme ||= @object_handler
    end

    def self.api_name
      "sites"
    end

    def self.parent_class
      Company
    end
  end
end
