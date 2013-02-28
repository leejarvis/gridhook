class UnfortunateSendgridFix
  def initialize(app)
    @app = app
  end

  def call(env)
    if env['PATH_INFO'] == Gridhook.config.event_receive_path
      env['CONTENT_TYPE'] = 'text/plain'
    end
    @app.call(env)
  end
end