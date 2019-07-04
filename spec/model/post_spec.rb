# -*- encoding: utf-8 -*-
require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user1) { FactoryBot.create(:user) }
  let(:post1) { FactoryBot.create(:post) }

  describe '.abbreviated_content' do
    context 'contentが20文字未満の場合' do
      it 'contentがそのまま返ること' do
        expect(post1.abbreviated_content).to eq "MyString"
      end
    end
    context 'contentが20文字以上の場合' do
      it 'contentが省略されること' do
        post2 = Post.new(content: 'a' * 20, user_id: 2)
        expect(post2.abbreviated_content).to eq "#{'a' * 19}..."
      end
    end
  end


end

