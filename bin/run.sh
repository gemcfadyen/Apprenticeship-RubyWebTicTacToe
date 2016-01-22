#!/usr/bin/env ruby

##Setup Load Path
$LOAD_PATH << File.expand_path("../../", __FILE__)

require 'sinatra'
require 'tic_tac_toe_web_app'

#TicTacToeWebApp.run!

ruby lib/tic_tac_toe_web_app.rb
