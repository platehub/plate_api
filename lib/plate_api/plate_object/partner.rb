module PlateApi::PlateObject
  class Partner < Base

    has_many :companies, :company, "PlateApi::PlateObject::Company"
    has_many :sites, :site, "PlateApi::PlateObject::Site"

    def self.api_name
      "partners"
    end

    def self.parent_class
      Partner
    end
  end
end
