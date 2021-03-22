
class GamesController < ApplicationController

    def new 
    end

    def create 
        selected_word =  params["game"]["word"]
        if selected_word
            num_chars = selected_word.length
            inital_board_layout = "_ " * num_chars
            game = Game.create(name: selected_word, remaining_num_guesses: 6, guessed_letters: inital_board_layout )
        redirect_to :new_game, notice: "Game created with word #{selected_word}!. sharablelink: http://localhost:3000/games/#{game.id}"
        end
    end


    def show 
       game_id = params[:id] 
       @game = Game.find(game_id)
       @current_image = Game.draw_board(@game.remaining_num_guesses)
        @board_layout = @game.guessed_letters
        
    end

    def update 
        current_game = Game.find(params["id"].to_i)
        guessed_letter = params["game"]["name"].strip
        if current_game.remaining_num_guesses <= -1
            redirect_to current_game, notice: "Youve maxed out your guesses!"
            return
        end

        if current_game && !guessed_letter.blank?
           
           if current_game.name.include?(guessed_letter)
            updated_guessed_letters = current_game.guessed_letters.split(" ")
            current_game.name.each_char.with_index do |c,i|
                if c == guessed_letter
                    updated_guessed_letters[i] = c
                end
            end
            updated_game = Game.update(current_game.id, guessed_letters: updated_guessed_letters.join(" "))
 
            if current_game.name === updated_game.guessed_letters.split(" ").join("")
                redirect_to current_game, notice: "Letter: #{guessed_letter} was correct! Congrats you guessed the word!"
            else   
                redirect_to current_game, notice: "Letter: #{guessed_letter} was correct!"
            end

        else
            Game.update(current_game.id, remaining_num_guesses: current_game.remaining_num_guesses - 1)
            if current_game.remaining_num_guesses - 1 == -1 
                redirect_to current_game, notice: "Letter: #{guessed_letter} was incorrect! you lose. The word was #{current_game.name}" 
            else
                redirect_to current_game, notice: "Letter: #{guessed_letter} was incorrect!"
            end
            
           end
        end
    end
end
