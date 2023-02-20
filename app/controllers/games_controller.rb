require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ('A'..'Z').to_a.sample(1).join
    end
  end

  def score
    @result = {}
    exist = JSON.parse(URI.open("https://wagon-dictionary.herokuapp.com/#{params[:word]}").read)['found']
    valid = params[:word].chars.all? do |letter|
      params[:word].upcase.count(letter) <= params[:grid].count(letter)
    end
    @result = if !exist
                {
                  message: "Sorry but #{params[:word].upcase} doesn't seem to be a valid English word",
                  score: 0
                }
              elsif !valid
                {
                  message: "Sorry but #{params[:word].upcase} can't be built out of #{params[:grid]}",
                  score: 0
                }
              else
                {
                  message: "Congrats! #{params[:word].upcase} is a valid word!",
                  score: params[:word].size
                }
              end
  end
end
