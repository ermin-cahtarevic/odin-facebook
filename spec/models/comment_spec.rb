require 'rails_helper'

RSpec.describe Comment, type: :model do
  before :each do
    user = User.create(first_name: 'User', last_name: 'Name', email: 'example@example.com', password: 'password',
                       password_confirmation: 'password')
    @post = user.posts.create(content: 'Post content')
  end

  context 'Validation tests' do
    subject { Comment.new }
    let(:create_comment) do
      User.new(first_name: 'User', last_name: 'Name', email: 'test@test.com', password: 'password',
               password_confirmation: 'password')
    end

    it 'is valid with valid attributes' do
      subject.comment_text = 'Test comment'
      subject.post_id = @post.id
      subject.user = create_comment
      expect(subject).to be_valid
    end

    it 'is not valid without comment text' do
      expect(subject).to_not be_valid
    end
  end

  context 'Association tests' do
    describe 'Comment model associations' do
      it 'belongs to user' do
        assc = Comment.reflect_on_association(:user)
        expect(assc.macro).to eq :belongs_to
      end

      it 'belongs to post' do
        assc = Comment.reflect_on_association(:post)
        expect(assc.macro).to eq :belongs_to
      end
    end
  end
end
