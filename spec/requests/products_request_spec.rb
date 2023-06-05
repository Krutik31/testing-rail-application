require 'rails_helper'

RSpec.describe '/products', type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { build :testuser }
  let(:product) { FactoryBot.create_list(:product, 1, user:) }

  describe 'GET /index' do
    it 'renders index page' do
      get products_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders show page' do
      get product_url(product)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    context 'while user is logged in' do
      it 'renders new page' do
        sign_in user
        get new_product_url
        expect(response).to be_successful
      end
    end

    context 'while user is not logged in' do
      it 'should not render new page' do
        sign_out user
        get new_product_url
        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end

  describe 'GET /edit' do
    context 'while user is logged in' do
      it 'renders edit page' do
        sign_in user
        get edit_product_url(product)
        expect(response).to be_successful
      end
    end

    context 'while user is not logged in' do
      it 'should not render edit page' do
        sign_out user
        get edit_product_url(product)
        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end

  describe 'POST /create' do
    let(:newproduct) { FactoryBot.attributes_for(:product) }

    context 'while user is logged in' do
      it 'creates a new product' do
        sign_in user
        expect do
          post products_url, params: { product: newproduct }
        end.to change(Product, :count).by(1)
      end

      it 'redirects to the index after creating a product' do
        sign_in user
        post products_url, params: { product: newproduct }
        expect(response).to redirect_to(root_url)
      end
    end

    context 'while user is not logged in' do
      it 'should not creates a new product' do
        sign_out user
        expect do
          post products_url, params: { product: newproduct }
        end.to change(Product, :count).by(0)
      end

      it 'should redirects to the signin page' do
        sign_out user
        post products_url, params: { product: newproduct }
        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end

  describe 'PATCH /update' do
    let(:updated_product) do
      {
        product_name: 'test product updated',
        price: 100,
        description: 'updated description'
      }
    end

    context 'while user is logged in' do
      it 'updates the requested product' do
        sign_in user
        patch product_url(product), params: { product: updated_product }
        expect(Product.last.product_name).to eq 'test product updated'
      end

      it 'redirects to the product' do
        sign_in user
        patch product_url(product), params: { product: updated_product }
        expect(response).to redirect_to(product_url(product))
      end
    end

    context 'while user is not logged in' do
      it 'should not update the requested product' do
        sign_out user
        patch product_url(product), params: { product: updated_product }
        expect(Product.last.product_name).not_to eq 'test product updated'
      end

      it 'should redirects to the signin page' do
        sign_out user
        patch product_url(product), params: { product: updated_product }
        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end

  describe 'DELETE /destroy' do
    let(:user_for_delete) { create :user }
    let(:product_for_delete) { FactoryBot.create(:product, user: user_for_delete) }

    context 'while user is logged in' do
      it 'destroys the requested product' do
        sign_in user_for_delete
        product_for_delete.reload
        expect do
          delete product_url(product_for_delete)
        end.to change(Product, :count).by(-1)
      end

      it 'redirects to the index after deleting a product' do
        sign_in user_for_delete
        delete product_url(product_for_delete)
        expect(response).to redirect_to(products_url)
      end
    end

    context 'while user is not logged in' do
      it 'should not destroy the requested product' do
        sign_out user_for_delete
        product_for_delete.reload
        expect do
          delete product_url(product_for_delete)
        end.to change(Product, :count).by(0)
      end

      it 'should redirects to the signin page' do
        sign_out user
        delete product_url(product_for_delete)
        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end
end
