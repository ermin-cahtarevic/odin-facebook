require 'rails_helper'

RSpec.describe Like, type: :model do
  before :each do
    @user = User.create(first_name: 'User', last_name: 'Name', email: 'example@example.com', password: 'password',
                        password_confirmation: 'password')
    @post = @user.posts.create(content: 'Post content')
  end

  context 'Validation tests' do
    subject { Like.new }
    let(:create_like) do
      User.new(first_name: 'User', last_name: 'Name', email: 'test@test.com', password: 'password',
               password_confirmation: 'password')
    end

    it 'is valid with valid attributes' do
      subject.user_id = @user.id
      subject.post_id = @post.id
      subject.user = create_like
      expect(subject).to be_valid
    end

    it 'is not valid without user_id and post_id' do
      expect(subject).to_not be_valid
    end
  end

  context 'Association tests' do
    describe 'Like model associations' do
      it 'belongs to user' do
        assc = Like.reflect_on_association(:user)
        expect(assc.macro).to eq :belongs_to
      end

      it 'belongs to post' do
        assc = Like.reflect_on_association(:post)
        expect(assc.macro).to eq :belongs_to
      end
    end
  end
end
