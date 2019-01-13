require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validate post' do
    subject { Post.new attrs }

    context 'title, summary and body are filled' do
      let(:attrs) { { title: 'title', summary: 'summary', body: 'body' } }
      it { is_expected.to be_valid }
    end

    context 'summary is not filled' do
      let(:attrs) { { title: 'title', body: 'body' } }
      it { is_expected.not_to be_valid }
    end
  end
end
