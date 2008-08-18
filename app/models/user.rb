class User < ActiveRecord::Base
  has_many :orders
  
  def name
    [first_name, last_name].join(' ')
  end
end
