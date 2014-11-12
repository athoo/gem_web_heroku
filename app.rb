require 'sinatra/base'
require 'ltp_checker'
require 'json'
require 'sinatra/namespace'

# web version of MovieCrawlerApp(https://github.com/ChenLiZhan/SOA-Crawler)
class LTPCheckerApp < Sinatra::Base

  register Sinatra::Namespace

  helpers do
    # RANK_LIST = { '1' => 'U.S.', '2' => 'Taiwan', '3' => 'DVD' }

    def get_checklist(word,rank)
      # words_after = {
      #   'rank' => []
      # }
      # word = params[:word]
      # words_after['rank'] = LTP.check_ltp("男人")[10].to_json
      words_after = LTP.check_ltp(word)[0,rank.to_i].to_json
    end

    # def get_form
    #   @post = params[:post]
    # end
    # def get_ranks(category)
    #   halt 404 if category.to_i > 3
    #   ranks_after = {
    #     'type' => 'rank_table',
    #     'category' => RANK_LIST[category],
    #     'rank' => []
    #   }
    #
    #   category = params[:category]
    #   ranks_after['rank'] = MovieCrawler.get_table(category)
    #   ranks_after
    # end

    # def get_infos(category)
    #   begin
    #     infos_after = {
    #       'type' => 'info_list',
    #       'category' => category,
    #       'info' => []
    #     }
    #
    #     category = params[:category]
    #     infos_after['info'] = MovieCrawler.movies_parser(category)
    #   rescue
    #     halt 400
    #   else
    #     infos_after
    #   end
    # end

    # def topsum(n)
    #   us1 = YAML.load(MovieCrawler::us_weekend).reduce(&:merge)
    #   tp1 = YAML.load(MovieCrawler::taipei_weekend).reduce(&:merge)
    #   dvd1 = YAML.load(MovieCrawler::dvd_rank).reduce(&:merge)
    #   keys = [us1, tp1, dvd1].flat_map(&:keys).uniq
    #   keys = keys[0, n]
    #
    #   keys.map! do |k|
    #     { k => [{us:us1[k] || "0" }, { tp:tp1[k] || "0" }, { dvd:dvd1[k] || "0"}] }
    #   end
    # end
  end

  get '/' do
    "It's really working."
  end

  post '/form' do
    get_checklist(params[:message],params[:rank])
    # "You said '#{params[:message]}'"
  end

  get '/form' do
    erb :form
  end


  namespace '/api/v1' do
    get '/check' do
      # content_type :json, charset: 'utf-8'
      get_checklist#(params[:word])#.to_json
    end

    get '/index' do
      send_file 'index.html'
    end
    # get '/info/:category.json' do
    #   content_type :json, charset: 'utf-8'
    #   get_infos(params[:category]).to_json
    # end
    #
    # post '/checktop' do
    #   content_type :json, charset: 'utf-8'
    #   req = JSON.parse(request.body.read)
    #   n = req['top']
    #   halt 400 unless req.any?
    #   halt 404 unless [*1..10].include? n
    #   topsum(n).to_json
    # end

    get '/info/' do
      "xsadas"
      # halt 400
    end
  end
end
