require 'rails_helper'

RSpec.describe Friendship, type: :model do
  before :each do
    @user1 = User.create(first_name: 'User1', last_name: 'Name', email: 'example1@example.com', password: 'password',
                         password_confirmation: 'password')
    @user2 = User.create(first_name: 'User2', last_name: 'Name', email: 'example2@example.com', password: 'password',
                         password_confirmation: 'password')
  end

  it '# creates a valid accepted_friendship' do
    accepted_friendship = Friendship.new(reciever_id: @user1.id, sender_id: @user2.id)
    accepted_friendship.status = true
    expect(accepted_friendship).to be_valid
  end

  it '# creates a valid pending_friendship' do
    pending_friendship = Friendship.new(reciever_id: @user1.id, sender_id: @user2.id)
    expect(pending_friendship).to be_valid
  end

  it '# creates a invalid friendship' do
    friendship = Friendship.new(reciever_id: '', sender_id: '')
    expect(friendship).to_not be_valid
  end

  context 'Association tests' do
    describe 'friendship model associations' do
      it 'belongs to sender' do
        assc = Friendship.reflect_on_association(:sender)
        expect(assc.macro).to eq :belongs_to
      end
      it 'belongs to reciever' do
        assc = Friendship.reflect_on_association(:reciever)
        expect(assc.macro).to eq :belongs_to
      end
    end
  end
end
