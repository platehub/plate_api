module ExampleApiResponses
  def base_response(id, type)
    {
      "data" => {
        "id" => id,
        "type" => type,
      }
    }
  end

  def show_site_response(id)
    base_response(id, "sites").deep_merge({
      "data" => {
        "attributes" => {
          "name" => "Site Name"
        }
      }
    })
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

  def update_site_response(id, new_name)
    base_response(id, "sites").deep_merge({
      "data" => {
        "attributes" => {
          "name" => new_name
        }
      }
      })
    end

  def update_site_not_found_response(id)
    {
      "errors" => [{
        "id" => id,
        "resource_type" => "sites",
        "status" => "404"
      }]
    }
  end

  def update_site_invalid_response(id)
    {
      "errors" => [{
        "id" => id,
        "resource_type" => "sites",
        "status" => "422"
      }]
    }
  end

end
