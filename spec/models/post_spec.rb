RSpec.describe Post, type: :model do
  context 'Validation tests' do
    subject { Post.new }
    let(:create_post) do
      User.new(first_name: 'User', last_name: 'Name', email: 'example@example.com', password: 'password',
               password_confirmation: 'password')
    end

    it 'is valid with valid attributes' do
      subject.content = 'Test content'
      subject.user = create_post
      expect(subject).to be_valid
    end

    it 'is not valid without a content' do
      expect(subject).to_not be_valid
    end
  end

  context 'Association tests' do
    describe 'Post model associations' do
      it 'belongs to user' do
        assc = Post.reflect_on_association(:user)
        expect(assc.macro).to eq :belongs_to
      end
    end
  end
end
