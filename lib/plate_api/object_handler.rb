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
      raise ArgumentError.new("`id` given for #find is not valid") unless id.is_a? Integer
      result = @api_connector.get("#{@handling_class.api_name}/#{id}")
      if result["data"]
        return @handling_class.new(result["data"]["id"], result["data"]["attributes"])
      else
        return nil
      end
    end
  end
end
