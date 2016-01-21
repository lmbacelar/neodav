class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  include Serializable
  io_attributes :email,:role

  extend FriendlyId
  friendly_id :email, use: :slugged

  def self.search query
    if query.present?
      where "name ilike '%#{query}%' OR designation ilike '%#{query}%'"
    else
      all
    end
  end
end
