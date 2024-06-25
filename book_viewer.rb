require "tilt/erubis"
require "sinatra"
require "sinatra/reloader"

before do
  @contents = File.readlines "data/toc.txt"
end

helpers do
  def in_paragraphs(text)
    text.split("\n\n").map do |paragraph|
      "<p>#{paragraph}</p>"
    end.join
  end
end

get "/" do
  @title = "The Adventures of Sherlock Holmes"

  erb :home
end

get "/chapters/:number" do
  number = params[:number].to_i
  @chapter_name = "Chapter #{number}: " + @contents[number - 1]

  redirect "/" unless (1..@contents.size).cover? number

  @chapter = File.read "data/chp#{number}.txt"

  erb :chapter, layout: :layout
end

not_found do
  redirect "/"
end