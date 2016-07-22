require 'bundler'
Bundler.require

class ApplicationController < Sinatra::Base

  get '/' do
    erb :index, :layout => :base
  end

  post '/results' do
    scss :style
    erb :results, :layout => :base
  end
end


#https://codepen.io/dylanbaumann/pen/BjNxgo