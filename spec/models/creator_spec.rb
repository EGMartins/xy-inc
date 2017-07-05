#spec/models/creator_spec.rb
require 'spec_helper'

describe Creator do
	it "has a valid factory" do
		expect(FactoryGirl.build(:creator)).to be_valid
	end
	it "is invalid without a name" do
		expect(FactoryGirl.build(:creator, name: nil)).not_to be_valid
	end
	it "does not have the same name model" do
		FactoryGirl.build(:creator, name: 'Test Model')
		expect(FactoryGirl.build(:creator, name: 'Test Model')).to be_valid
	end
	it "check case sensitive name" do
		FactoryGirl.build(:creator, name: 'Test Model')
		expect(FactoryGirl.build(:creator, name: 'test model')).to be_valid
	end
end

RSpec.feature "Creating Model" do
	scenario "A user creates a new model" do
		visit "/"
		click_link "Criar novo modelo"
		expect(page).to have_content("Crie seu modelo")
		fill_in "creator[name]", with: "client"
		fill_in "creator[info]", with: "Model for a client info"
		click_link "Adicionar Campo"

	end
end
