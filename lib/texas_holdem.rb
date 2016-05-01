%w(
  bet_manager
  card
  cards
  hand
  hand_evaluator
  player
  texas_holdem_dealer
).each { |file| require "texas_holdem/#{file}" }
