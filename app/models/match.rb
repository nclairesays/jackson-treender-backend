class Match < ApplicationRecord
    def token
        JWT.encode({ user_id: self.id }, 'jackson')
    end

    #can be reused to find existing, but also when we want to render nils so that current user can fill in their resposne
    def self.filter_nils(current_user)
        filtered_user2 = self.select { |entry| (entry.user2_id == current_user.id && entry.user2_response == nil) }
    end


    def self.find_existing_entry (current_user, matchee_id)
        filtered_user2 = self.filter_nils(current_user)
        matched = filtered_user2.find { |entry| 
           entry.user1_id == matchee_id
        }
    end

    
    # if this returns true, then do not do anything with the params
    def self.find_completed_entries(current_user, matchee_id)
        b = self.any?{|e| (current_user.id == e.user2_id && e.user1_id == matchee_id.to_i && e.user2_response != nil) }
     
        c = self.any?{|e|  current_user.id == e.user1_id && e.user2_id == matchee_id.to_i && e.user2_response == nil}

            
        if (b == true || c == true) 
            true; 
        else 
            false;
        end
        
    end

# {
#     "id": 74,
#     "user1_id": 18,
#     "user2_id": 7,
#     "user1_response": true,
#     "user2_response": null,
#     "created_at": "2019-03-06T22:16:39.298Z",
#     "updated_at": "2019-03-06T22:16:39.298Z"
# }

# {
#     "id": 11,
#     "user1_id": 7,
#     "user2_id": 18,
#     "user1_response": true,
#     "user2_response": null,
#     "created_at": "2019-03-05T16:05:39.635Z",
#     "updated_at": "2019-03-05T16:05:39.635Z"
# },

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


    def self.get_potentials(current_user)

        already_swiped_ids = []

        swiped_entries = self.all.select{|match| match.user1_id == current_user.id || match.user2_id == current_user.id}
        swiped_entries.map{ |e| 
            if e.user1_id == current_user.id
                already_swiped_ids << e.user2_id
            elsif e.user2_id == current_user.id && e.user2_response != nil
                already_swiped_ids << e.user1_id
            else
                nil
            end
        }

        potentials = User.all.reject { |user|
            already_swiped_ids.include?(user.id) || user.id == current_user.id
        }

        potentials.sample(5)

    end



end


