require 'sinatra/base'
require 'rbconfig'

# $PROGRAM_NAME = 'web_admin_d'  # set the process name

class WebAdmin < Sinatra::Base
  enable :logging
  set :bind, '0.0.0.0'           # listen on any interface

  TFILE = "/tmp/token.txt"

  helpers do
    def raspi?
      RbConfig::CONFIG["arch"].match(/arm-linux/)
    end

    def link_to_unless_current(path, label)
      return label if path == request.path_info
      "<a href='#{path}'>#{label}</a>"
    end

    def navdata
      %w(/:Home /erb:Token /time:Time /ls:LS /gps_packets:20_GPS_Packets /cell_modem_status:Cell_Modem_Status)
    end

    def navbar
      navdata.map do |el|
        link_to_unless_current(*el.split(':'))
      end.join(' | ')
    end
  end

  get '/' do
    erb "Hello World Dog2!"
  end

  get '/erb' do
    @token = File.exist?(TFILE) ? File.read(TFILE) : "Undefined"
    erb :token_form
  end

  post '/token' do
    @token = params["new_token"]
    puts params
    File.write(TFILE, @token)
    redirect '/erb'
  end

  get '/time' do
    erb "Current Time: #{Time.now}"
  end

  get '/ls' do
    erb `ls -1`.gsub("\n","<br/>")
  end

  get '/gps_packets' do
    if raspi?
      erb `gpspipe -r -n 10`.gsub("\n","<br/>")
    else
      erb "ONLY RUNS ON RASPBERRY PI"
    end
  end

  get '/cell_modem_status' do
    if raspi?
      erb `/usr/bin/sudo /bin/get-modem-status.py --html`
    else
      erb "ONLY RUNS ON RASPBERRY PI"
    end
  end
end

