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
        },
        "relations" => {
          "theme_id" => 1,
          "company_id" => 1
        }
      }
    })
  end
  alias_method :delete_site_response, :show_site_response

  def show_site_not_found_response(id)
    {
      "errors" => [{
        "id" => id,
        "resource_type" => "sites",
        "status" => "404"
      }]
    }
  end
  alias_method :delete_site_not_found_response, :show_site_not_found_response

  def update_site_response(id, new_name)
    base_response(id, "sites").deep_merge({
      "data" => {
        "attributes" => {
          "name" => new_name
        },
        "relations" => {
          "theme_id" => 1,
          "company_id" => 1
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

  def create_site_response(company_id, name, theme_id)
    base_response(1, "sites").deep_merge({
      "data" => {
        "attributes" => {
          "name" => name
        },
        "relations" => {
          "theme_id" => theme_id,
          "company_id" => company_id
        }
      }
    })

  end

end
