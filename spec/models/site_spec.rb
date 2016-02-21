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

require 'rails_helper'

RSpec.describe Site, type: :model do
  it { FactoryGirl.create_list :site, 2 }
end
