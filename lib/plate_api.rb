require "plate_api/version"
require "plate_api/connector"
require "plate_api/object_handler"
require "plate_api/plate_object/base"
Dir[File.join(__dir__,"plate_api/plate_object/", "*.rb")].each {|file| require file }
require "plate_api/request"
require "plate_api/get_request"
require "plate_api/delete_request"
require "plate_api/post_request"
require "plate_api/post_multipart_request"
require "plate_api/put_request"


module PlateApi
end
