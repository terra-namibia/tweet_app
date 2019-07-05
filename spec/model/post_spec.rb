# -*- encoding: utf-8 -*-
require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:all) do
    p 'before(:all)'
  end
  before(:each) do
    p 'before(:each)'
  end
  let(:user1) { FactoryBot.create(:user) }
  let(:post1) { FactoryBot.create(:post) }
  let(:post2) { FactoryBot.create(:post, content: 'a' * 20) }

  describe '.abbreviated_content' do
    context 'contentが20文字未満の場合' do
      subject { post1.abbreviated_content }
      it 'contentがそのまま返ること' do
        # pending 'pendingする場合'
        # skip 'skipする場合'
        # expect(post1.abbreviated_content).to eq "MyString"
        is_expected.to eq "MyString"
      end
    end
    context 'contentが20文字以上の場合' do
      subject { post2.abbreviated_content }
      it 'contentが省略されること' do
        # expect(post2.abbreviated_content).to eq "#{'a' * 19}..."
        is_expected.to eq "#{'a' * 19}..."
      end
    end
  end


end

