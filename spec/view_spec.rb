require 'board'
require 'player_symbols'
require 'erb'
require 'nokogiri'
require 'uri'
require 'grid_formatter'
require 'game_state'

RSpec.describe "ERB Views" do

  it "displays empty cell in grid" do
    @game_state = GameState.new(GridFormatter.new.format(Board.new), PlayerSymbols::all, nil)

    html_doc = transform_to_html(load_template.result(binding()))
    first_cell = ahref_links(html_doc).first

    expect(first_cell.text.strip).to eq "1"
  end

  it "sends back grid as zero indexed based" do
    @game_state = GameState.new(GridFormatter.new.format(Board.new), PlayerSymbols::all, nil)

    html_doc = transform_to_html(load_template.result(binding()))
    first_link = ahref_links(html_doc).first
    query_params = query_params_from(first_link)

    expect(query_params['grid']).to eq ["[0, 1, 2, 3, 4, 5, 6, 7, 8]"]
  end

  it "sends move selected as zero index based" do
    @game_state = GameState.new(GridFormatter.new.format(Board.new), PlayerSymbols::all, nil)

    html_doc = transform_to_html(load_template.result(binding()))
    first_link = ahref_links(html_doc).first
    query_params = query_params_from(first_link)

    expect(query_params['move-taken']).to eq ["0"]
  end

  it "landing page with empty grid contains 9 links" do
    @game_state = GameState.new(GridFormatter.new.format(Board.new), PlayerSymbols::all, nil)

    html_doc = transform_to_html(load_template.result(binding()))

    expect(count_ahref_links(html_doc)).to eq 9
  end

  it "landing page only shows links for unoccupied cells" do
    @game_state = GameState.new(GridFormatter.new.format(Board.new([PlayerSymbols::X, nil, nil, PlayerSymbols::O, nil, nil, PlayerSymbols::O, nil, nil])), PlayerSymbols::all, nil)

    html_doc = transform_to_html(load_template.result(binding()))

    expect(count_ahref_links(html_doc)).to eq 6
  end

  it "landing page shows moves made" do
    @game_state = GameState.new(GridFormatter.new.format(Board.new([PlayerSymbols::X, nil, nil, PlayerSymbols::O, nil, nil, PlayerSymbols::O, nil, nil])), PlayerSymbols::all, nil)

    html_doc = transform_to_html(load_template.result(binding()))

    expect(count_number_of("O", all_table_entries(html_doc))).to eq 2
    expect(count_number_of("X", all_table_entries(html_doc))).to eq 1
  end

  it "landing page has no links when game is won" do
    @game_state = GameState.new(GridFormatter.new.format(Board.new([PlayerSymbols::X, PlayerSymbols::X, PlayerSymbols::X, PlayerSymbols::O, nil, nil, PlayerSymbols::O, nil, nil])), PlayerSymbols::all, "Winner")

    html_doc = transform_to_html(load_template.result(binding()))

    expect(count_ahref_links(html_doc)).to eq 0
  end

  it "shows unoccupied cells as one indexed based when game is over" do
    @game_state = GameState.new(GridFormatter.new.format(Board.new([PlayerSymbols::X, PlayerSymbols::X, PlayerSymbols::X, PlayerSymbols::O, nil, nil, PlayerSymbols::O, nil, nil])), PlayerSymbols::all, "Winner")
    html_doc = transform_to_html(load_template.result(binding()))

    table_entries = all_table_entries(html_doc)

    expect(table_entries.include?("5")).to be true
    expect(table_entries.include?("6")).to be true
    expect(table_entries.include?("8")).to be true
    expect(table_entries.include?("9")).to be true
  end

  it "landing page shows game status when it is set" do
    @game_state = GameState.new(GridFormatter.new.format(Board.new([PlayerSymbols::X, PlayerSymbols::O, PlayerSymbols::X, PlayerSymbols::O, PlayerSymbols::O, PlayerSymbols::X, PlayerSymbols::X, PlayerSymbols::X, PlayerSymbols::O])), PlayerSymbols::all, "Draw")

    html_doc = transform_to_html(load_template.result(binding()))

    expect(game_status_displayed(html_doc)).to eq "Draw"
  end

  it "landing page shows no status when game status is unset" do
    @game_state = GameState.new(GridFormatter.new.format(Board.new([nil, nil, nil, PlayerSymbols::O, PlayerSymbols::O, PlayerSymbols::X, PlayerSymbols::X, PlayerSymbols::X, PlayerSymbols::O])), PlayerSymbols::all, nil)

    html_doc = transform_to_html(load_template.result(binding()))

    expect(game_status_displayed(html_doc)).to eq ""
  end

  def load_template
    ERB.new File.new("views/landing_page.erb").read
  end

  def transform_to_html(stream)
    Nokogiri::HTML(stream)
  end

  def ahref_links(html)
    html.css("a")
  end

  def query_params_from(link)
    CGI::parse(URI::parse(link['href']).query)
  end

  def count_ahref_links(html)
    ahref_links(html).length
  end

  def all_table_cells(html)
    html.css("td")
  end

  def all_table_entries(html)
    all_table_cells(html).text
  end

  def count_number_of(symbol, table_entries)
    table_entries.count(symbol)
  end

  def game_status_displayed(html)
    html.css("p").first.text
  end
end
