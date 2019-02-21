class Match < ApplicationRecord

   #filter for nils so that we can enter in resposne to user2_response
    def filter_nils
        filtered_user1 = Match.all.select { |entry| entry.user1_id === 4 } # change 1 to current user id
        matched = filtered_user1.select { |entry| 
           entry.user2_response == nil
        }
    end



    def filter_user (id) 
        filtered_user = Match.all.select { |entry| entry.user1_id == id || entry.user2_id == id} 

        matched = filtered_user.select { |entry| 
            entry.user1_response === true && entry.user2_response === true
        }
    end
    

end


