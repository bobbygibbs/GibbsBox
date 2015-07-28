require 'sinatra'
require 'listen'

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

get "/:page" do |n|
    send_file n
end