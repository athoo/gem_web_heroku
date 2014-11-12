require 'sinatra/base'
require 'ltp_checker'
require 'json'
require 'sinatra/namespace'
require 'haml'

# web version of MovieCrawlerApp(https://github.com/ChenLiZhan/SOA-Crawler)
class LTPCheckerApp < Sinatra::Base
  set :views, Proc.new { File.join(root, "views") }

  register Sinatra::Namespace

  helpers do
    # RANK_LIST = { '1' => 'U.S.', '2' => 'Taiwan', '3' => 'DVD' }

    def get_checklist(word,rank)
      words_after = LTP.check_ltp(word)[0,rank.to_i]
      
    end

  end

  get '/' do
    "It's really working."
  end

  post '/form' do
    @data = get_checklist(params[:message],params[:rank])
    haml :form
  end

  get '/form' do
    @data = []
    haml :form
  end


  namespace '/api/v1' do
    get '/check' do
      # content_type :json, charset: 'utf-8'
      get_checklist#(params[:word])#.to_json
    end

    get '/index' do
      send_file 'index.html'
    end


    get '/info/' do
      "xsadas"
      # halt 400
    end
  end
end
