require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:test_user)
    @product = products(:test)
  end

  test 'should get index' do
    get products_url
    assert_response :success, 'should not be able to get index action page.'
  end

  test 'should get show' do
    get product_url(@product)
    assert_response :success, 'should not be able to get index action page.'
  end

  test 'should get new' do
    get new_product_url
    assert_response :success, 'should be able to get new action page, while user is logged in.'
  end

  test 'should not get new' do
    sign_out users(:test_user)
    get new_product_url
    assert_response :redirect, 'New action page can not be fetched if user is not logged in.'
  end

  test 'should create product' do
    assert_difference('Product.count', 1, 'Product has not been created') do
      post products_url,
           params: {
             product: {
               product_name: 'Test Product',
               price: '200',
               description: 'Test description'
             }
           }
    end

    assert_redirected_to root_url, 'can not be redirect to index page after creating a product.'
  end

  test 'should not create product' do
    sign_out users(:test_user)
    assert_no_difference('Product.count', 'Product has created while user is not logged in.') do
      post products_url,
           params: {
             product: {
               product_name: 'Test Product',
               price: '200',
               description: 'Test description'
             }
           }
    end
  end

  test 'should get edit' do
    get edit_product_url(@product)
    assert_response :success, 'should be able to get edit action page, while user is logged in.'
  end

  test 'should not get edit' do
    sign_out users(:test_user)
    get edit_product_url(@product)
    assert_response :redirect, 'Edit action page can not be fetched if user is not logged in.'
  end

  test 'should update product' do
    patch product_url(@product),
          params: {
            product: {
              price: '50000'
            }
          }

    assert_redirected_to product_url(@product), 'can not be redirect to show page after updating a product.'
    assert_equal 50_000, Product.find(@product.id).price, 'Product has not been updated.'
  end

  test 'should not update product' do
    sign_out users(:test_user)
    patch product_url(@product),
          params: {
            product: {
              price: '30000'
            }
          }

    assert_not_equal 30_000, Product.find(@product.id).price, 'Product has been updated, while user is not logged in.'
  end

  test 'should delete product' do
    assert_difference('Product.count', -1, 'Product has not been deleted') do
      delete product_url(@product)
    end

    assert_redirected_to products_url, 'can not be redirect to index page after deleting a product.'
  end

  test 'should not delete product' do
    sign_out users(:test_user)
    assert_no_difference('Product.count', 'Product has been deleted, while user is not logged in') do
      delete product_url(@product)
    end
  end
end
