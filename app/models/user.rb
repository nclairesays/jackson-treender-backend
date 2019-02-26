class User < ApplicationRecord
    has_secure_password

    def token
        JWT.encode({ user_id: self.id }, 'jackson')
    end

    def self.get_potentials(current_user)
        potentials = self.all.sample(10).select{ |user| user != current_user}
    end
end
