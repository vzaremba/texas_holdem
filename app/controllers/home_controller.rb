class HomeController < ApplicationController
  def index
    @game = Game.new()
    @game.start
    @reveal_cards = false
    scorer = GameScorer.new(@game)
    session[:the_game]  = @game
    session[:the_score] = scorer
  end
  def play
    @reveal_cards = true
    @scorer = session[:the_score]
    @game   = session[:the_game]
    render :index
  end
end
