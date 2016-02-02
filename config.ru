#Setup Load Path
lib = File.expand_path("../lib", __FILE__)
$:.unshift(lib)

require 'web_ttt_controller'

run WebTTTController

