require 'faker'

# helpers I found here: http://pastie.caboo.se/137188
class Fixnum
  def percent_of_the_time(&block)
    raise(ArgumentError, 'Fixnum should be between 1 and 100 to be used with the times method') unless self > 0 && self <= 100
    yield block if (Kernel.rand(99)+1) <= self
  end
end

# (3..6).times do
class Range
  def times(&block)
    self.to_a.rand.times(&block)
  end
end

# since our players are over 18, make some random date between after that
# birthyear
def random_birthday
  random_date(80.years.ago.to_i, 18.years.ago.to_i)
end

def random_date(min, max)
  Time.at(min + rand(max-min)).to_date
end

# add this to each task you wish to not be run in production
def check_environment
  if RAILS_ENV.downcase == "production"
    raise "You can't do this in production. Think of the children!"
  end
end

namespace :db do

  namespace :faker do

    desc "Creates some fake users"
    task :users => :environment do

      check_environment

      size = ENV['SIZE'].to_i

      if size == 0
        size = 100
      end

      size.times do |t|
        u = User.create(:first_name => Faker::Name.first_name,
                        :last_name  => Faker::Name.last_name,
                        :address    => Faker::Address.street_address,
                        :city       => Faker::Address.city,
                        :state      => Faker::Address.us_state_abbr,
                        :zip        => Faker::Address.zip_code,
                        :email      => Faker::Internet.email,
                        :birthdate  => random_birthday)

         90.percent_of_the_time do
           u.orders << Order.new(:invoice => t,
                                 :description => Faker::Company.bs,
                                 :created_at => random_date(Time.now.to_i, 1.month.ago.to_i))
         end

      end
    end
  end

end