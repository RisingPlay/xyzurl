class Myurl < ActiveRecord::Base
	validates :url, presence: true;
end
