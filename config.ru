use Rack::Static,
  :urls => ["/images", "/js", "/css"],
  :root => "./"

run lambda { |env|
  file_path = ".#{env['PATH_INFO']}"

  file_path = './index.html' if file_path == './'

  if File.exists?(file_path)
    code = 200
    content = File.open(file_path, File::RDONLY)
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