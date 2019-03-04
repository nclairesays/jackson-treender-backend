class User < ApplicationRecord
    has_secure_password

    def token
        JWT.encode({ user_id: self.id }, 'jackson')
    end  
    
    def self.find_match_entries(current_user)
        Match.select{|match|
            match.user1_id == current_user.id || match.user2_id == current_user.id
        }
    end

    def self.get_potentials(current_user)
       
        existing_entries = self.find_match_entries(current_user) # exist.. 7 with entries
    
        potentials = self.all.sample(10).select{ |user| 

            binding.pry
            existing_entries.select{|entry|  user.id != entry.user2_id }
            # existing_entries.select{|entry| user.id != entry.user1_id || user.id != entry.user2_id }
        }

        
    end
end

