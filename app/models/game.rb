GUESSES_TO_IMAGE_MAPPING = {
    "6" => "Stage0.png",
    "5" => "Stage1.png",
    "4" => "Stage2.png",
    "3"=> "Stage3.png",
    "2" => "Stage4.png",
    "1"  => "Stage5.png",
    "0" => "Stage6.png"
}

class Game < ApplicationRecord
    def self.draw_board(remaining_num_guesses)
        image = GUESSES_TO_IMAGE_MAPPING[remaining_num_guesses.to_s]
        if !image 
        return "Stage7.png"
        end
        return image
    end
end