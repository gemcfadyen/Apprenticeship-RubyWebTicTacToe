#Setup Load Path
$LOAD_PATH << File.expand_path("../lib", __FILE__) << File.expand_path("../../Apprenticeship-RubyTicTacToe/lib", __FILE__)


require 'tic_tac_toe_web_app'

run TicTacToeWebApp


