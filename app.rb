class App
  def call(env)
    @req = Rack::Request.new(env)
    if @req.request_method == 'GET' && @req.path == '/time'
      show_time
    else
      show_404
    end
  end

  private

  def header
    { 'Content-Type' => 'text/plain' }
  end

  def show_404
    [404, header, ["Path not found\n"]]
  end

  def show_time
    response = DateTimeFormat.new(DateTime.now, @req.params['format'])
    response.wrong? ? [400, header, [response.bad_response]] : [200, header, [response.good_response]]
  end
end
