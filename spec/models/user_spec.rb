require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validate user' do
    subject { User.create attrs }

    context 'created user is not admin' do
      let(:attrs) { { email: 'abracadabra@mail', password: '111111' } }
      it { expect(subject.has_role?(:user)).to be true }
    end
  end
end
