require 'rack/utils'

module Rack
  class FlashSession

    def initialize(app, *args)
      args = ['_session_id'] if args.empty?
      @app = app
      @session_keys = args
    end

    def call(env)
      if env['HTTP_USER_AGENT'] =~ /^(Adobe|Shockwave) Flash/ then
        params = ::Rack::Request.new(env).params
        env['HTTP_COOKIE'] = params.select{|k,v| @session_keys.include?(k)}.map{|k,v| [k, ::Rack::Utils.escape(v)].join('=')}.join(';')
      end
      @app.call(env)
    end

  end
end
