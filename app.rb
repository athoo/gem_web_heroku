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

    def get_checklist(word, rank, cat)
      mixed = Hash.new{ |h,k| h[k] = Hash.new(&h.default_proc) }
      if cat.include?('bltp')
        ltp = LTP.check_ltp(word)[0,rank.to_i]
      end
      if cat.include?('bchineselsa')
        chineselsa = LTP.check_chineselsa(word)[0,rank.to_i]
      end
      if cat.include?('btfidf')
        tfidf = LTP.check_tfidf(word)[0,rank.to_i]
      end

      0.upto(rank.to_i-1) do |i|
        if cat.include?('btfidf')
          mixed[word]["tfidf"][tfidf[i][0]]=tfidf[i][1]
        end
        if cat.include?('bchineselsa')
          mixed[word]["chineselsa"][chineselsa[i][0]]=chineselsa[i][1]
        end
        if cat.include?('bltp')
          mixed[word]["ltp"][ltp[i][0]]=ltp[i][1]
        end
      end
      mixed
    end

  end

  get '/' do
    "It's really working."
  end

  post '/form' do
    # @data = get_checklist(params[:message],params[:rank],params[:btfidf],params[:bltp],params[:bchineselsa])
    print params[:cat]
    @data = get_checklist(params[:message],params[:rank], params[:cat])
    @len = params[:cat].length
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
