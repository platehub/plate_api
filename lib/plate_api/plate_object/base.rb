module PlateApi::PlateObject
  class Base
    attr_reader :id, :attributes, :relations
    attr_accessor :object_handler

    def initialize(id, attributes, relations, object_handler=nil)
      raise ArgumentError.new("No `name` found in `attributes` for #new") if attributes["name"].to_s.empty?

      @id = id
      @attributes = attributes
      @relations = relations
      @object_handler = object_handler
    end

    def api_name
      self.class.api_name
    end

    def to_s
      "<Plate #{self.class.name.split('::').last}, @id=#{@id}, @attributes=#{@attributes}, @object_handler=#{@object_handler}>"
    end

    def inspect
      to_s
    end
  end
end
