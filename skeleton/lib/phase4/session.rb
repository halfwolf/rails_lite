require 'json'
require 'webrick'

module Phase4
  class Session
    # find the cookie for this app
    # deserialize the cookie into a hash
    def initialize(req)

      @cookie = deserialize(req.cookies)
    end

    def deserialize(cookies)
      cookie = cookies.select {|cookie| cookie.name == "_rails_lite_app"}
      cookie.empty? ? {} : JSON.parse(cookie[0].value)
    end

    def [](key)
      @cookie[key]
    end

    def []=(key, val)
      @cookie[key] = val
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_session(res)
      new_cookie =WEBrick::Cookie.new("_rails_lite_app", @cookie.to_json)
      res.cookies << new_cookie
    end
  end
end
