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

RSpec.describe SitesController, type: :request do
  let(:site) { FactoryGirl.create :site }

  describe "#show" do
    before { get "/sites/#{site.id}" }
    it { expect(response).to be_success }
  end

  describe "#edit" do
    before { get "/sites/#{site.id}/edit" }
    it { expect(response).to be_success }
  end
end
