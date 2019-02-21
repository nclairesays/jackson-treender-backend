class Match < ApplicationRecord

  

    def self.filter_existing_entry (current_user, matchee_id)
        filtered_user2 = self.select { |entry| entry.user2_id == current_user.id && entry.user2_response == nil }
        matched = filtered_user2.find { |entry| 
           entry.user1_id == matchee_id
        }
    end

 


    #this is to filter if they are both true
    def filter_matches (current_user) 
        filtered_user = Match.all.select { |entry| entry.user1_id == current_user.id || entry.user2_id == current_user.id} 

        matched = filtered_user.select { |entry| 
            entry.user1_response === true && entry.user2_response === true
        }
    end



end


