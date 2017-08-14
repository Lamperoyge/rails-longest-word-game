class GamesController < ApplicationController
  def game
     grid = []
     7.times do
  grid << ("A".."Z").to_a.sample
  end
   @new_grid = grid.join(' ')
   @start_time = Time.now.to_i
  end


  def score
  # TODO: runs the game and return detailed hash of result
      @attempt = params[:user_guess]
      start_time = params[:start_time].to_i
      end_time = Time.now.to_i
      grid_check = @attempt.chars.all? do |letter|
        @attempt.count(letter) <= 7
      end
      if grid_check
        url = "https://wagon-dictionary.herokuapp.com/#{@attempt}"
        word = JSON.parse(open(url).read)
        english_check = word["found"]
      end
      total_time = end_time - start_time
      if grid_check && english_check
        @score = @attempt.length / total_time
    else
      @score = 0
    end
  end
end

