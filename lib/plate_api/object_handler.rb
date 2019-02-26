require_relative "plate_object/site"
require_relative "connector"

module PlateApi
  class ObjectHandler

    def initialize(handling_class, api_connector)
      raise ArgumentError.new("`handling_class` given for #new is not valid") unless handling_class
      raise ArgumentError.new("`api_connector` given for #new is not valid") unless api_connector
      @handling_class = handling_class
      @api_connector = api_connector
    end

    def find(id)
      raise ArgumentError.new("`id` given for #find is not valid") unless id
      result = @api_connector.get(resource_path(id))
      if result["data"]
        return new_object(result)
      else
        puts "No result: #{result}"
        return nil
      end
    end

    def update(id, attributes)
      raise ArgumentError.new("`id` given for #update is not valid") unless id
      raise ArgumentError.new("`attributes` given for #update is not valid") unless attributes.is_a? Hash
      result = @api_connector.put(resource_path(id), {"data" => attributes})

      if result["data"]
        return new_object(result)
      else
        puts "No result: #{result}"
        return nil
      end
    end

    def create(parent_id, attributes)
      raise ArgumentError.new("`parent_id` given for #create is not valid") unless parent_id
      raise ArgumentError.new("`attributes` given for #create is not valid") unless attributes.is_a? Hash
      result = @api_connector.post(collection_path(@handling_class.parent_class, parent_id), {"data" => attributes})

      if result["data"]
        return new_object(result)
      else
        puts "No result: #{result}"
        return nil
      end
    end

    def delete(id)
      raise ArgumentError.new("`id` given for #find is not valid") unless id
      result = @api_connector.delete(resource_path(id))
      if result["data"]
        return new_object(result)
      else
        puts "No result: #{result}"
        return nil
      end
    end

    private

    # Construct a new object of @handling_class, given a succesful api_response
    def new_object(api_response)
      @handling_class.new(
        api_response["data"]["id"],
        api_response["data"]["attributes"],
        api_response["data"]["relations"],
        self
      )
    end

    def resource_path(id)
      "#{@handling_class.api_name}/#{id}"
    end

    def collection_path(parent_class=nil, parent_id=nil)
      if (parent_class != nil) ^ (parent_id != nil)
        raise ArgumentError.new("An invalid combination `parent_class` and `parent_id` is given. Provide both or none.")
      end

      if parent_class
        "#{parent_class.api_name}/#{parent_id}/#{@handling_class.api_name}"
      else
        "#{@handling_class.api_name}"
      end
    end
  end
end
