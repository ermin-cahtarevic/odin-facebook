require 'rails_helper'

RSpec.describe User, type: :model do
  it 'validates first name, last name and email' do
    user = User.new(first_name: '', last_name: '', email: '')
    expect(user.valid?).to be(false)
  end

  it 'has many posts' do
    assc = User.reflect_on_association(:posts)
    expect(assc.macro).to eq :has_many
  end
end
