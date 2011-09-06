require 'sinatra'
require './lib/rmsgen'
require 'json'

use Rack::Session::Pool

get '/' do
  @notes = Rmsgen::FsPolnoteGroup.new('/home/lacus/Mail/Lakedenman/stallman/new').all
  erb :index
end

post '/create' do
  session[:notes] ||= {}
  session[:notes][params[:note][:id]] = { :body => params[:note][:body] }
  redirect "/edit/#{params[:note][:id]}"
  session
end

get '/edit/:id' do
  id = params[:id]
  body = session[:notes]["#{id}"][:body]
  @polnote = Rmsgen::Polnote.new(body)
  erb :edit
end

put '/update/:id' do
  body = session[:notes][params[:id]][:body]
  @polnote = Rmsgen::Polnote.new(body)
  @inquirer = Rmsgen::Inquirer.new(@polnote, $stdout, params[:note][:answers])
  @polnote.title = Rmsgen::Titleizer.new(@polnote, :title => params[:note][:title]).to_html
  @polnote.body = @inquirer.body
  session[:notes][params[:id]][:html] = @polnote.to_html
  redirect 'edit/' + params[:id]
end
