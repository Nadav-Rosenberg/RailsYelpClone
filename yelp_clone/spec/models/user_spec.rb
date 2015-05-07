require 'spec_helper'

describe User, type: :model do
  # it { is_expected.to have_many :reviewed_restaurants }
  it { is_expected.to have_many :reviews }
end