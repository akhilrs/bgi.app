class Phone < ActiveRecord::Base
  belongs_to :user
  has_many :calllogs, dependent: :destroy
end
