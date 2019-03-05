class User < ApplicationRecord
    has_secure_password

    def token
        JWT.encode({ user_id: self.id }, 'jackson')
    end

    def self.get_potentials(current_user)

        already_swiped_ids = []

        swiped_entries = Match.all.select{|match| match.user1_id == current_user.id || match.user2_id == current_user.id}
        swiped_entries.map{ |e| 
            if e.user1_id == current_user.id
                already_swiped_ids << e.user2_id
            elsif e.user2_id == current_user.id
                already_swiped_ids << e.user1_id
            else
                nil
            end
        }

        potentials = self.all.reject { |user|
            already_swiped_ids.include?(user.id) || user.id == current_user.id
        }

        potentials.sample(10)


    end
    
end