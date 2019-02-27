module PlateApi::PlateObject
  class Base
    attr_reader :id, :attributes, :relations
    attr_accessor :object_handler

    HasOneRelations = {}
    HasManyRelations = {}

    def initialize(id, attributes, relations, object_handler=nil)
      raise ArgumentError.new("No `name` found in `attributes` for #new") if attributes["name"].to_s.empty?

      set_relation_ids(relations)

      @id = id
      @attributes = attributes
      @relations = relations
      @object_handler = object_handler
    end

    def api_name
      self.class.api_name
    end

    def reload
      raise ArgumentError.new("No object_handler is set.") unless @object_handler
      @object_handler.find(@id)
    end

    def update(attributes)
      raise ArgumentError.new("Input `attributes` is not a Hash") unless attributes.is_a? Hash
      raise ArgumentError.new("No object_handler is attached to this object") unless @object_handler
      if new_site = @object_handler.update(@id, attributes)
        @attributes = new_site.attributes
      else
        raise ArgumentError.new("The update was unsuccesful.")
      end
    end

    def delete
      @object_handler.delete(@id)
    end

    def to_s
      "<Plate #{self.class.name.split('::').last}, @id=#{@id}, @attributes=#{@attributes}, @object_handler=#{@object_handler}>"
    end

    def inspect
      to_s
    end

    private

    def self.has_one(name, klass)
      self.attr_accessor "#{name}_id".to_sym
      HasOneRelations[name.to_s] = klass
      define_has_one_method(name)
    end

    def self.define_has_one_method(name)
      define_method(name.to_s) do
        id = self.send("#{name}_id")
        return nil unless id

        @object_handler.api_connector.send("#{name}_handler").find(id)
      end
    end

    def self.has_many(plural_name, singular_name, klass)
      HasManyRelations[plural_name.to_s] = klass
      define_has_many_method(singular_name, plural_name)
    end

    def self.define_has_many_method(singular_name, plural_name)
      define_method(plural_name.to_s) do
        @object_handler.api_connector.send("#{singular_name}_handler").index(self.class, @id)
      end
    end

    def set_relation_ids(relations_attributes)
      self.class::HasOneRelations.keys.each do |relation_name|
        val = relations_attributes["#{relation_name}_id"]
        if val
          send("#{relation_name}_id=", val)
        end
      end
    end
  end
end
