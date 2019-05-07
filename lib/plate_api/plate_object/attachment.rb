module PlateApi::PlateObject
  class Attachment < Base

    has_one :site, "PlateApi::PlateObject::Site"
    has_one :attachment_folder, "PlateApi::PlateObject::AttachmentFolder"

    def download
      @object_handler.api_connector.get("attachments/#{@id}/download", {}, :raw)
    end

    def self.api_name
      "attachments"
    end

    def self.parent_class
      Site
    end
  end
end
