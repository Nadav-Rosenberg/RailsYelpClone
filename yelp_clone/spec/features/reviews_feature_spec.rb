require 'rails_helper'

feature 'reviewing' do
  before { @restaurant = Restaurant.create name: 'KFC' }

  scenario 'allows users to leave a review using a form' do
    sign_up_for_tests
    leave_review
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end

  scenario 'when parent restaurant is destroyed, child reviews are destroyed as well' do
    sign_up_for_tests
    leave_review
    click_link 'Delete KFC'
    expect(current_path).to eq '/restaurants'
    expect(page).not_to have_content('so so')

  end

  scenario 'reviews can be deleted' do
    sign_up_for_tests
    leave_review
    visit '/'
    click_link 'KFC'
    click_link 'Delete Review'
    expect(page).not_to have_content('so so')
    expect(page).to have_content('Review deleted successfully')
    expect(current_path).to eq "/restaurants/#{@restaurant.id}"

  end

  scenario 'Reviews can only be deleted by the user that created them' do
    sign_up_for_tests
    leave_review
    visit '/'
    click_link('Sign out')
    sign_up_for_tests 2
    click_link 'KFC'
    click_link 'Delete Review'
    expect(page).to have_content('so so')
    expect(page).not_to have_content('Review deleted successfully')
    expect(page).to have_content('Only author can delete review')
    expect(current_path).to eq "/restaurants/#{@restaurant.id}"  
  end

  scenario 'users can only leave one review per restaurant' do
    sign_up_for_tests
    leave_review
    leave_review "another review"
    expect(page).to have_content("You can only leave one review per restaurant")
    visit '/'
    expect(page).not_to have_content("another review")

  end
  
end