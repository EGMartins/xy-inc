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
		expect(FactoryGirl.build(:creator, name: 'Test Model')).not_to be_valid
	end
	it "check case sensitive name" do
		FactoryGirl.build(:creator, name: 'Test Model')
		expect(FactoryGirl.build(:creator, name: 'test model')).not_to be_valid
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
		click_button "Criar o Modelo"
		expect(page).to have_content "Modelos já criados"
	end
end

RSpec.describe "Model management", :type => :request do

  it "creates a instance and redirects to the instance's page" do
    get "/creators/new"
    expect(response).to render_template(:new)

    post "/creators", :params => { :creator => {name: "client", info: "Just another test"} }
    expect(response).to have_http_status(:found)
    
  end

  it "does not render a different template" do
    get "/creators/new"
    expect(response).to_not render_template(:show)
  end
end
