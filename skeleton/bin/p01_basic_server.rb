require 'webrick'

root = File.expand_path '/'
server = WEBrick::HTTPServer.new :Port => 3000, :DocumentRoot => root


server.mount_proc '/' do |req, res|
  res.content_type = "text/text"
  res.body = req.path

end

server.start

trap('INT') { server.shutdown }

# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPRequest.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPResponse.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/Cookie.html
