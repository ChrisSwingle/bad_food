require 'bundler'
require_relative 'models/model.rb'
Bundler.require

class ApplicationController < Sinatra::Base

  get '/' do
    erb :index, :layout => :base
  end

  post '/results' do
    format_request_and_send_api_call
    erb :results, :layout => :base
  end
end


#https://codepen.io/dylanbaumann/pen/BjNxgo