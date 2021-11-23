module PlateApi::PlateObject
  class Base
    attr_reader :id, :attributes, :relations
    attr_accessor :object_handler

    HasOneRelations = {}
    HasManyRelations = {}

    def initialize(id, attributes, relations, object_handler = nil)
      @id = id
      @object_handler = object_handler
      initialize_state(attributes, relations)
    end

    def api_name
      self.class.api_name
    end

    def reload
      raise ArgumentError, "No object_handler is set." unless @object_handler

      reinitialize(@object_handler.find(@id))
      self
    end

    def update(attributes)
      raise ArgumentError, "Input `attributes` is not a Hash" unless attributes.is_a?(Hash)
      raise ArgumentError, "No object_handler is attached to this object" unless @object_handler

      if new_object = @object_handler.update(@id, attributes)
        reinitialize(new_object)
      else
        raise ArgumentError, "The update was unsuccesful."
      end
      self
    end

    def delete
      raise ArgumentError, "No object_handler is attached to this object" unless @object_handler

      @object_handler.delete(@id)
    end

    def to_s
      "<Plate #{self.class.name.split('::').last}, @id=#{@id}, @attributes=#{@attributes}, @object_handler=#{@object_handler}>"
    end

    def inspect
      to_s
    end

    def method_missing(method_name, *args, &block)
      if attributes[method_name.to_s]
        attributes[method_name.to_s]
      elsif attributes["content"] && attributes["content"][method_name.to_s]
        attributes["content"][method_name.to_s]["value"]
      else
        super
      end
    end

    def respond_to_missing?(method_name, include_private = false)
      return true if attributes[method_name.to_s]
      return true if attributes["content"] && attributes["content"][method_name.to_s]

      super
    end

    def ==(other)
      other.id == @id && other.class == self.class
    end

    private

    def reinitialize(new_object)
      initialize_state(new_object.attributes, new_object.relations)
    end

    def initialize_state(attributes, relations)
      set_relation_ids(relations)
      @attributes = attributes
      @relations = relations
    end

    def set_relation_ids(relations_attributes)
      HasOneRelations[self.class.name] ||= {}

      return unless relations_attributes

      self.class::HasOneRelations[self.class.name].keys.each do |relation_name|
        val = relations_attributes["#{relation_name}_id"]
        if val
          send("#{relation_name}_id=", val)
        end
      end
    end

    class << self
      private

      def has_one(name, klass)
        HasOneRelations[self.name] ||= {}
        attr_accessor("#{name}_id")
        HasOneRelations[self.name][name.to_s] = klass
        define_has_one_method(name, klass)
      end

      def define_has_one_method(name, klass)
        define_method(name.to_s) do
          id = send("#{name}_id")
          return nil unless id

          @object_handler.api_connector.handler(Object.const_get(klass)).find(id)
        end
      end

      def has_many(plural_name, singular_name, klass, define_create_method = false)
        HasManyRelations[name] ||= {}
        HasManyRelations[name][plural_name.to_s] = klass
        define_has_many_methods(plural_name, klass)
        define_create_method(singular_name, klass) if define_create_method
      end

      def define_has_many_methods(plural_name, klass)
        define_method(plural_name.to_s) do |params = {}|
          @object_handler.api_connector.handler(
            Object.const_get(klass)
          ).index(self.class, @id, params)
        end

        define_method("#{plural_name}_total_count") do
          @object_handler.api_connector.handler(
            Object.const_get(klass)
          ).index_total_count(self)
        end

        define_method("all_#{plural_name}") do |params = {}, &block|
          @object_handler.api_connector.handler(
            Object.const_get(klass)
          ).index_block(self.class, @id, params, &block)
        end
      end

      def define_create_method(singular_name, klass)
        define_method("create_#{singular_name}") do |create_attributes|
          @object_handler.api_connector.handler(Object.const_get(klass)).create(self, create_attributes)
        end
      end
    end
  end
end
