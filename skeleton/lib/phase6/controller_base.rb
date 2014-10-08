require_relative '../phase5/controller_base'

module Phase6
  class ControllerBase < Phase5::ControllerBase

    def initialize(req, res, route_params={})
      @req = req
      @res = res
      @params = Phase5::Params.new(req, route_params)
    end

    # use this with the router to call action_name (:index, :show, :create...)
    def invoke_action(name)
      self.send(name)
    end
  end
end
