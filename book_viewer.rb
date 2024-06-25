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

  @title = "Chapter #{number}"
  @chapter = File.read "data/chp#{number}.txt"

  @chapter_name = "Chapter #{number}: " + @contents[number - 1]

  erb :chapter, layout: :layout
end