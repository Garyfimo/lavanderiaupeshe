use Rack::Static,
  :urls => ["/images", "/js", "/css"],
  :root => "./"

run lambda { |env|
  file_path = ".#{env['PATH_INFO']}"

  if File.exists?(file_path)
    code = 200
    content = File.open(".#{env['PATH_INFO']}", File::RDONLY)
  else
    code = 404
    content = ""
  end

  [
    code,
    {
      'Content-Type'  => 'text/html',
      'Cache-Control' => 'public, max-age=86400'
    },
    content
  ]
}