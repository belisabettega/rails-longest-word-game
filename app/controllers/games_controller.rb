require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10).map { |_letter| ('A'..'Z').to_a.sample }
  end

  def english_word?(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    json_file = URI.open(url).read
    json_file = JSON.parse(json_file)
    if json_file["found"] == true
      return true
    else
      return false
    end
  end

  def word_is_valid?(attempt, grid)
    attempt_a = attempt.upcase.chars
    grid = grid.split(//)
    attempt_a.each_with_index do |letter, index|
      if grid.include? letter
        grid.delete_at(grid.index(letter))
        attempt_a[index] = 0
      else
        attempt_a[index] = 1
      end
    end
    attempt_a.sum.zero?
  end
  
  def score
    @word = params[:word]
    @letters = params[:letters]
    @english_word = english_word?(@word)
    @valid_word = word_is_valid?(@word, @letters)
  end
end
