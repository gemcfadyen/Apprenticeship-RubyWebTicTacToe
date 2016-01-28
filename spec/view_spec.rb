require 'board'
require 'player_symbols'
require 'erb'
require 'nokogiri'

RSpec.describe "ERB Views" do

  it "landing page with empty grid contains 9 links" do
    @formatted_rows = Board.new.grid_for_display
    @valid_moves = PlayerSymbols::all.map {|i| i.to_s}

    html_doc = transform_to_html(load_template.result(binding()))

    expect(count_ahref_links(html_doc)).to eq 9
  end

  it "landing page only shows links for unoccupied cells" do
    @formatted_rows = Board.new([PlayerSymbols::X, nil, nil, PlayerSymbols::O, nil, nil, PlayerSymbols::O, nil, nil]).grid_for_display
    @valid_moves = PlayerSymbols::all.map {|i| i.to_s}

    html_doc = transform_to_html(load_template.result(binding()))

    expect(count_ahref_links(html_doc)).to eq 6
  end

  it "landing page shows moves made" do
    @formatted_rows = Board.new([PlayerSymbols::X, nil, nil, PlayerSymbols::O, nil, nil, PlayerSymbols::O, nil, nil]).grid_for_display
    @valid_moves = PlayerSymbols::all.map {|i| i.to_s}

    html_doc = transform_to_html(load_template.result(binding()))

    expect(count_number_of("O", all_table_entries(html_doc))).to eq 2
    expect(count_number_of("X", all_table_entries(html_doc))).to eq 1
  end

  it "landing page has no links when game is won" do
    @formatted_rows = Board.new([PlayerSymbols::X, PlayerSymbols::X, PlayerSymbols::X, PlayerSymbols::O, nil, nil, PlayerSymbols::O, nil, nil]).grid_for_display
    @valid_moves = PlayerSymbols::all.map {|i| i.to_s}
    @game_status = "Winner"

    html_doc = transform_to_html(load_template.result(binding()))

    expect(count_ahref_links(html_doc)).to eq 0
  end

  it "landing page shows game status when it is set" do
    @formatted_rows = Board.new([PlayerSymbols::X, PlayerSymbols::O, PlayerSymbols::X, PlayerSymbols::O, PlayerSymbols::O, PlayerSymbols::X, PlayerSymbols::X, PlayerSymbols::X, PlayerSymbols::O]).grid_for_display
    @valid_moves = PlayerSymbols::all.map {|i| i.to_s}
    @game_status = "Draw"

    html_doc = transform_to_html(load_template.result(binding()))

    expect(game_status_displayed(html_doc)).to eq "Draw"
  end

  it "landing page shows no status when game status is unset" do
    @formatted_rows = Board.new([nil, nil, nil, PlayerSymbols::O, PlayerSymbols::O, PlayerSymbols::X, PlayerSymbols::X, PlayerSymbols::X, PlayerSymbols::O]).grid_for_display
    @valid_moves = PlayerSymbols::all.map {|i| i.to_s}
    @game_status = nil

    html_doc = transform_to_html(load_template.result(binding()))

    expect(game_status_displayed(html_doc)).to eq ""
  end

  def load_template
    ERB.new File.new("views/landing_page.erb").read
  end

  def transform_to_html(stream)
    Nokogiri::HTML(stream)
  end

  def count_ahref_links(html)
    html.css("a").length
  end

  def all_table_entries(html)
    html.css("td").text
  end

  def count_number_of(symbol, table_entries)
    table_entries.count(symbol)
  end

  def game_status_displayed(html)
    html.css("p")[1].text
  end
end
