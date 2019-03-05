module PlateApi::PlateObject
  class Partner < Base

    has_many :companies, :company, "PlateApi::PlateObject::Company"

    def self.api_name
      "partners"
    end

    def self.parent_class
      Partner
    end
  end
end
