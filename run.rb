require 'sinatra'
require 'io/console'

enable :sessions

get "/" do 
    send_file 'login.html'
end

post "/login/:usr" do
	usr = params[:username]
	if !IO.read("usr.txt").split().include? usr then
		redirect back
	end
	#open('usr.txt', 'a') do |f|
	#	f << "\n" << usr
	#end
	session[:username] = usr
	redirect to('/index')
end

get "/index" do
	if !session[:username].nil? then
		puts session[:username]
		send_file 'main.html'
	end
	redirect to('/')
end

get "/logout" do
	session[:username] = nil
	redirect to('/')
end

post "/actions/:msg" do |n|
	if !session[:username].nil? then
		msg = params[:message]
		open('log.txt', 'a') do |f|
			f << "\n" << session[:username] + ": " + msg
		end
	end
    redirect back
end

get "/log" do
    IO.read("log.txt").length.to_s
end

get "/:page" do |n|
    send_file n
end 