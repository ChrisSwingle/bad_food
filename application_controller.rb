require 'bundler'
require_relative 'models/model.rb'
Bundler.require

class ApplicationController < Sinatra::Base

  get '/' do
    erb :index, :layout => :base
  end

  post '/results' do
    zipcode = params[:zipcode]
    @final_hash = format_request_and_send_api_call(zipcode)
    
    erb :results, :layout => :base
  end
end

