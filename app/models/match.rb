class Match < ApplicationRecord

   #filter for nils so that we can then enter in resposne to user2_response (after if can't find, then create a new entry in matches)
    # def self.filter_nils (current_user)
    #     filtered_user1 = Match.all.select { |entry| entry.user1_id === current_user.id }
    #     matched = filtered_user1.select { |entry| 
    #        entry.user2_response == nil 
    #     }
    # end

    # def self.filter_matchee(matchee_id)
    #     filtered_matchee = Match.all.select { |entry| entry.user1_id === matchee_id }
    # end
   

    def self.filter_existing_entry (current_user, matchee_id)
        filtered_user2 = self.select { |entry| entry.user2_id == current_user.id && entry.user2_response == nil }
        matched = filtered_user2.find { |entry| 
           entry.user1_id == matchee_id
        }
    end

 


    # filtered_entry[0].update(user2_response: params[:current_user_response])




    #this is to filter if they are both true
    def filter_matches (current_user) 
        filtered_user = Match.all.select { |entry| entry.user1_id == current_user.id || entry.user2_id == current_user.id} 

        matched = filtered_user.select { |entry| 
            entry.user1_response === true && entry.user2_response === true
        }
    end



end


