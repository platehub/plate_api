module PlateApi::PlateObject
  class AttachmentFolder < Base

    has_one :site, "PlateApi::PlateObject::Site"
    has_many :attachments, :attachment, "PlateApi::PlateObject::Attachment"

    def self.api_name
      "attachment_folders"
    end

    def self.parent_class
      Site
    end
  end
end
