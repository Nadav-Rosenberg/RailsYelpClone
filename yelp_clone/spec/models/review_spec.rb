require 'spec_helper'

describe Review, type: :model do
  it { is_expected.to belong_to :restaurant }

  it 'is not valid with a rating of more than 5' do
    review = Review.new(thoughts: "great", rating: 6)
    expect(review).to have(1).error_on(:rating)
  end 
end
