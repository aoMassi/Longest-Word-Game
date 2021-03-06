require "open-uri"
class GamesController < ApplicationController


  def valid_english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json["found"]
  end

  def new
    @letters = Array.new(12) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = (params[:word] || "").upcase
    @letters = params[:letters].split
    @included = included?(@word, @letters)
    @valid_english_word = valid_english_word?(@word)   
  end

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

end
