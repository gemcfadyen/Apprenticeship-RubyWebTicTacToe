require 'board'
require 'player_symbols'
require 'erb'
require 'nokogiri'

RSpec.describe "ERB Views" do

  it "landing page with empty grid contains 9 links" do
    @formatted_rows = Board.new.grid_for_display
    @valid_moves = PlayerSymbols::all.map {|i| i.to_s}
    @game_status = nil

    template = load_template
    rendered = template.result(binding())

    links = count_ahref_links(rendered)
    expect(links.length).to eq 9
  end

  it "landing page only has links for unoccupied cells" do
    @formatted_rows = Board.new([PlayerSymbols::X, nil, nil, PlayerSymbols::O, nil, nil, PlayerSymbols::O, nil, nil]).grid_for_display
    @valid_moves = PlayerSymbols::all.map {|i| i.to_s}
    @game_status = nil

    template = load_template
    rendered = template.result(binding())

    links = count_ahref_links(rendered)
    expect(links.length).to eq 6
  end

  def load_template
    ERB.new File.new("views/landing_page.erb").read
  end

  def count_ahref_links(rendered)
    html_doc = Nokogiri::HTML(rendered)
    html_doc.css("a")
  end
end
