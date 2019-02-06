module PlateApi
  class Connector
    def initialize(secret_key)
      @secret_key = secret_key
    end

    def secret_key
      return secret_key
    end
  end
end
