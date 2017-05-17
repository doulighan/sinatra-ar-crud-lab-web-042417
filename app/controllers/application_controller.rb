require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do 
    redirect '/posts'
  end

  get '/posts/new' do 
    erb :new
  end

  get '/posts/:id' do 
    post_id = params[:id].to_i
    if Post.pluck(:id).include?(post_id)
      @post = Post.find(params[:id])
      erb :show
    else
      erb :'404'
    end
  end 

  get '/posts/:id/edit' do 
    @post = Post.find_by(id: params[:id])
    erb :edit
  end

  patch '/posts/:id' do 
    @post = Post.find_by(id: params[:id])
    @post.update(name: params[:name])
    @post.update(content: params[:content])
    erb :show
  end

  delete '/posts/:id/delete' do 
    @post = Post.find_by(id: params[:id]).destroy
    erb :delete
  end

  get '/posts' do 
    @posts = Post.all
    erb :index
  end

  post '/posts' do 
    Post.create(name: params["name"], content: params["content"])
    redirect '/posts'
  end
end