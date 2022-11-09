require 'rails_helper'

RSpec.describe 'Testing recipes view', type: :feature do
  describe 'Recipes#index' do
    before(:each) do
      user = User.create name: 'Tom', email: 'tommy@example.com', password: 'password'
      (1..5).each do |i|
        user.recipes.create name: "Recipe number #{i}", preparation_time: 60,
                            cooking_time: 90, description: 'Steps goes here', public: true
      end

      visit new_user_session_path
      fill_in 'Email', with: 'tommy@example.com'
      fill_in 'Password', with: 'password'
      click_button 'Log in'
      visit recipes_path
    end

    it 'should be able to see delete button for each recipe' do
      within('body') do
        expect(find_all('button').length).to eq 7
      end
    end
  end
end