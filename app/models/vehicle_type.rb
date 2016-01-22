class VehicleType < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  include Serializable
  io_attributes :name, :description

  extend FriendlyId
  friendly_id :name, use: :slugged

  def self.search query
    if query.present?
      where "name ilike '%#{query}%' OR description ilike '%#{query}%'"
    else
      all
    end
  end

  def to_s
    name
  end
end
