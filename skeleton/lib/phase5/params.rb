require 'uri'

module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    def initialize(req, route_params = {})
      @params = {}
      parse_www_encoded_form(req.body)
      parse_www_encoded_form(req.query_string)
    end

    def [](key)
      @params[key]
    end

    def to_s
      @params.to_json.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      return nil unless www_encoded_form

      parameters = URI::decode_www_form(www_encoded_form)
      parameters.each_index do |idx|

        nested = parse_key(parameters[idx][0])
        unless nested.count == 1
          base = { nested.pop => parameters[idx][1] }
          until nested.count == 1
            new_key = nested.pop
            base = { new_key => base }
          end

          base = {nested.pop => base}
          @params = @params.deep_merge(base)
        else
          base = { nested.pop => parameters[idx][1] }
          @params = @params.deep_merge(base)
        end
      end
    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      key.split(/\]\[|\[|\]/)
    end
  end
end
