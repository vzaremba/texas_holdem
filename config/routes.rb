TexasHoldem::Application.routes.draw do
  root 'home#index'
  get  'home/play' => 'home#play'
end
