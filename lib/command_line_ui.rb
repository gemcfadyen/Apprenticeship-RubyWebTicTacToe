require 'prompt_writer'
require 'prompt_reader'
require 'player_options'

class CommandLineUI

  def initialize(writer, reader)
    @writer = writer
    @reader = reader
  end

  def get_move_from_player(board)
    writer.show_board(board)
    value = read_users_move

    zero_indexed(get_validated_move(value, board))
  end

  def replay?
    writer.replay
    replay_option = reader.get_input()
    replay_option.upcase == ReplayOption::Y
  end

  def print_game_status(board)
    writer.show_board(board)
    if board.winning_combination?
      return writer.show_winning_message(board.winning_symbol)
    end

    if !board.free_spaces?
      return writer.show_draw_message
    end
  end

  def get_player_option
    get_validated_player_option(read_player_option)
  end

  private

  attr_reader :writer, :reader

  def read_users_move
    writer.ask_for_next_move
    reader.get_input
  end

  def read_player_option
    writer.show_player_options
    reader.get_input
  end

  def get_validated_player_option(value)
    while !valid_player_option?(value)
      writer.error_message
      value = read_player_option
    end
    PlayerOptions::get_player_type_for_id(to_number(value))
  end

  def valid_player_option?(value)
    numeric?(value) ?  PlayerOptions::valid_ids.include?(to_number(value)) : false
  end

  def get_validated_move(value, board)
    while !valid?(value, board)
      writer.show_board(board)
      writer.error_message
      value = read_users_move
    end
    to_number(value)
  end

  def valid?(value, board)
    numeric?(value) ? one_indexed(board.vacant_indices).include?(to_number(value)) : false
  end

  def numeric?(input)
    to_number(input)
    true
  rescue ArgumentError
    false
  end

  def to_number(value)
    Integer(value)
  end

  def one_indexed(vacant_indices)
    vacant_indices.collect { |i| i + 1 }
  end

  def zero_indexed(value)
    value - 1
  end
end
