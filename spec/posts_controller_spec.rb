# -*- encoding: utf-8 -*-
require 'rails_helper'

RSpec.describe PostsController, type: :controller do


  describe 'GET #index' do
    context 'paramsに正常パラメータをセットした時' do
  
      subject { get :index }

      it { is_expected.to be_success }
      it { is_expected.to render_template 'index' }
    end
  end

    
end