require 'sinatra'
require 'io/console'

get "/" do 
    send_file 'main.html'
end

post "/actions/:msg" do |n|
    msg = params[:message]
    open('log.txt', 'a') do |f|
        f << "\n" << msg
    end
    redirect back
end

get "/log" do
    IO.read("log.txt").length.to_s
end

get "/:page" do |n|
    send_file n
end 