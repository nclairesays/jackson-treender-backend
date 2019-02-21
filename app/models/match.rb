class Match < ApplicationRecord

   #filter for nils so that we can then enter in resposne to user2_response (after if can't find, then create a new entry in matches)
    def self.filter_nils (current_user)
        filtered_user1 = Match.all.select { |entry| entry.user1_id === current_user.id } # change current_user to current_user.id later 
        matched = filtered_user1.select { |entry| 
           entry.user2_response == nil 
        }
    end



    def filter_matches (current_user) 
        filtered_user = Match.all.select { |entry| entry.user1_id == current_user.id || entry.user2_id == current_user.id} 

        matched = filtered_user.select { |entry| 
            entry.user1_response === true && entry.user2_response === true
        }
    end
    

end


