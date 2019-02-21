module ExampleApiResponses
  def show_site_response(id)
    {
      "data" => {
        "id" => id,
        "type" => "sites",
        "attributes" => {
          "name" => "Site Name"
        }
      }
    }
  end

  def show_site_not_found_response(id)
    {
      "errors" => [{
        "id" => id,
        "resource_type" => "sites",
        "status" => "404"
      }]
    }
  end

end
