class User < ActiveRecord::Base
  has_many :connections
  
  def self.authenticate_or_create_with(auth)
    c = Connection.find_or_create_by_uid_and_provider(auth["uid"], auth["provider"])
    if c.user.nil?
      c.user = User.create!(:name => auth["info"]["name"])
      c.save
    end
    c.user
  end
end
