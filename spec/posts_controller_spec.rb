# -*- encoding: utf-8 -*-
require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user1) { FactoryBot.create(:user) }
  let(:post1) { FactoryBot.create(:post) }
  let(:params) { {} }  
  let(:session) { {user_id: user1.id} }

  describe 'GET #index' do
    context '正常系' do
      subject { get :index, params: params, session: session }

      it { is_expected.to be_success }
      it { is_expected.to render_template 'index' }
      it 'postsが取得できていること' do
        subject
        expect(assigns(:posts)).to eq [post1]
      end

    end
  end

  describe 'GET #show' do
    context '正常系' do
      before { params.merge!(id: post1.id) }
      subject { get :show, params: params, session: session }
      
      it { is_expected.to be_success }
      it { is_expected.to render_template 'show' }
      it 'postが取得できていること' do
        subject
        expect(assigns(:post)).to eq post1
      end
    end
  end
    
  describe 'GET #new' do
    context '正常系' do
      subject { get :new, params: params, session: session }

      it { is_expected.to be_success }
      it { is_expected.to render_template 'new' }
      it '新しいインスタンスを作成していること' do
        subject
        expect(assigns(:post)).to be_a_new(Post)
      end
    end
  end

  describe 'POST #create' do
    context '正常系' do
      before { params.merge!(content: 'テスト投稿', user_id: user1.id) }
      subject { post :create, params: params, session: session }

      it { is_expected.to be_redirect }      
      it {
        is_expected.to redirect_to controller: 'posts' ,
                                   action: 'index'
      }
      
      it 'DBを１件追加していること' do
        expect{ subject }.to change(Post, :count).by(1)
      end

    end
  end

  describe 'GET #edit' do
    context '正常系' do
      before { params.merge!(id: post1.id) }
      subject { get :edit, params: params, session: session }
      
      it { is_expected.to be_success }
      it { is_expected.to render_template 'edit' }
      it 'postが取得できていること' do
        subject
        expect(assigns(:post)).to eq post1
      end
    end
  end

  describe 'POST #update' do
    context '正常系' do
      before { params.merge!(id: post1.id, content: '投稿更新') }
      subject { post :update, params: params, session: session }

      it { is_expected.to be_redirect }
      it {
        is_expected.to redirect_to controller: 'posts',
                                   action: 'index'
      }
      it 'DBを更新していること' do
        subject
        post1.reload
        expect(post1.content).to eq '投稿更新'
      end
    end
  end

  describe 'POST #destroy' do
    context '正常系' do
      before { params.merge!(id: post1.id) }
      subject { post :destroy, params: params, session: session }

      it { is_expected.to be_redirect }
      it {
        is_expected.to redirect_to controller: 'posts' ,
                                   action: 'index'
      }
      it 'DBを１件削除していること' do
        expect{ subject }.to change(Post, :count).by(-1)
      end
    end
  end



end

