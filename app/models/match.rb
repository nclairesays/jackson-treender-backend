class Match < ApplicationRecord
    def token
        JWT.encode({ user_id: self.id }, 'jackson')
    end

    #can be reused to find existing, but also when we want to render nils so that current user can fill in their resposne
    def self.filter_nils(current_user)
        filtered_user2 = self.select { |entry| entry.user2_id == current_user.id && entry.user2_response == nil }
    end


    def self.find_existing_entry (current_user, matchee_id)
        filtered_user2 = self.filter_nils(current_user)
        matched = filtered_user2.find { |entry| 
           entry.user1_id == matchee_id
        }
    end

    


 





    #this is to filter if they are both true, this will be sent to the chat
    def self.filter_matches (current_user) 
        users = []

        filtered_user = Match.all.select { |entry| entry.user1_id == current_user.id || entry.user2_id == current_user.id} 

        matched = filtered_user.select { |entry| 
            entry.user1_response === true && entry.user2_response === true
        }

        matched.map{ |match|
            if match.user1_id != current_user.id
                users << User.find(match.user1_id)
            else 
                users << User.find(match.user2_id)
            end
        }
        return users
        
    end



end


