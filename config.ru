#Setup Load Path
lib = File.expand_path("../lib", __FILE__)
ttt_lib = File.expand_path("../../Apprenticeship-RubyTicTacToe/lib", __FILE__)
$:.unshift(lib).unshift(ttt_lib)

require 'tic_tac_toe_web_app'

run TicTacToeWebApp

