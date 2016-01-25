class Fuel < ActiveRecord::Base
  validates :code,        presence: true, uniqueness: true
  validates :description, presence: true, uniqueness: true

  default_scope { order :description }

  include Serializable
  io_attributes :code, :description

  extend FriendlyId
  friendly_id :code, use: :slugged

  def self.search query
    if query.present?
      where "code = '#{query}' OR description ilike '%#{query}%'"
    else
      all
    end
  end

  def to_s
    code
  end
end
