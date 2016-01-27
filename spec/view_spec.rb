require 'board'
require 'player_symbols'
require 'erb'
require 'nokogiri'

RSpec.describe "ERB Views" do

  it "landing page with empty grid contains 9 links" do
    @formatted_rows = Board.new.grid_for_display
    @valid_moves = PlayerSymbols::all.map {|i| i.to_s}
    @game_status = nil

    rendered = load_template.result(binding())
    html_doc = transform_to_html(rendered)
    links = count_ahref_links(html_doc)
    expect(links.length).to eq 9
  end

  it "landing page only has links for unoccupied cells" do
    @formatted_rows = Board.new([PlayerSymbols::X, nil, nil, PlayerSymbols::O, nil, nil, PlayerSymbols::O, nil, nil]).grid_for_display
    @valid_moves = PlayerSymbols::all.map {|i| i.to_s}
    @game_status = nil

    rendered = load_template.result(binding())
    html_doc = transform_to_html(rendered)
    links = count_ahref_links(html_doc)
    expect(links.length).to eq 6
  end

  it "landing page has no links when game is won" do
    @formatted_rows = Board.new([PlayerSymbols::X, PlayerSymbols::X, PlayerSymbols::X, PlayerSymbols::O, nil, nil, PlayerSymbols::O, nil, nil]).grid_for_display
    @valid_moves = PlayerSymbols::all.map {|i| i.to_s}
    @game_status = "Winner"

    rendered = load_template.result(binding())
    html_doc = transform_to_html(rendered)

    links = count_ahref_links(html_doc)
    expect(links.length).to eq 0
  end

  it "landing page shows winning message when game is won" do
    @formatted_rows = Board.new([PlayerSymbols::X, PlayerSymbols::X, PlayerSymbols::X, PlayerSymbols::O, nil, nil, PlayerSymbols::O, nil, nil]).grid_for_display
    @valid_moves = PlayerSymbols::all.map {|i| i.to_s}
    @game_status = "Winner"

    rendered = load_template.result(binding())
    html_doc = transform_to_html(rendered)
    all_paragraphs = html_doc.css("p")[1].text
    expect(all_paragraphs).to eq "Winner"
  end

  def load_template
    ERB.new File.new("views/landing_page.erb").read
  end

  def transform_to_html(stream)
    Nokogiri::HTML(stream)
  end

  def count_ahref_links(html)
    html.css("a")
  end
end
