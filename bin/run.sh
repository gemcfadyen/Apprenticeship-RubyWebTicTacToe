#!/usr/bin/env ruby

##Setup Load Path
$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require 'sinatra'
require 'tic_tac_toe_web_app'

TicTacToeWebApp.run!
