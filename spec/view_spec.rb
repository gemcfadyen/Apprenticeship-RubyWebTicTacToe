require 'board'
require 'player_symbols'
require 'erb'
require 'nokogiri'

RSpec.describe "ERB Views" do

  it "landing page with empty grid contains 9 links" do
    @formatted_rows = Board.new.grid_for_display
    p @formatted_rows.to_s
    @valid_moves = PlayerSymbols::all
    @game_status = nil

    template = ERB.new File.new("views/landing_page.erb").read
    rendered = template.result(binding())

    html_doc = Nokogiri::HTML(rendered)
    links = html_doc.css("a") # finds links on the page
    expect(links.length).to eq 9
  end
end

