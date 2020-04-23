require 'rails_helper'

RSpec.describe ApiUser, type: :model do
  it 'has a valid factory' do
    expect(create(:api_user)).to be_valid
  end

  # Validations
  it { should validate_presence_of(:email) }
  it { should validate_length_of(:email).is_at_most(255) }
  it { is_expected.to allow_value('email@address.foo').for(:email) }
  it { is_expected.to_not allow_value('email').for(:email) }
  it { is_expected.to_not allow_value('email@domain').for(:email) }
  it { is_expected.to_not allow_value('email@domain.').for(:email) }
  it { is_expected.to_not allow_value('email@domain.a').for(:email) }
end
