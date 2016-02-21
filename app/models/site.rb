# == Schema Information
#
# Table name: sites
#
#  id         :integer          not null, primary key
#  name       :string
#  host       :string
#  subdomain  :string
#  data       :hstore
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Site < ActiveRecord::Base
  validates :subdomain, presence: true, uniqueness: true
  validates :host, uniqueness: true, allow_nil: true
  validates :name, presence: true

  store_accessor :data, :tmp

  before_validation :generate_subdomain

  private

  def generate_subdomain
    name = SecureRandom.uuid.to_s[0, 5]
    while Site.where(subdomain: name).count > 0
      name = SecureRandom.uuid.to_s[0, 5]
    end
    self.subdomain = name
  end
end
