require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test 'the truth' do
    assert true
  end

  setup do
    @product = products(:one)
    @product2 = products(:two)
    @product3 = products(:three)
  end

  # Product Name Validation Testings
  test 'product name can not be blank' do
    assert_not @product.save, 'product name can not be blank.'
  end

  test 'product name minimum characters' do
    @product.product_name = 'a'
    assert_not @product.save, 'product name must have minimum 2 characters.'
  end

  test 'product name maximum characters' do
    @product.product_name = 'a' * 21
    assert_not @product.save, 'product name can have maximum 20 characters.'
  end

  # Price Validation Testings
  test 'price can not be blank' do
    assert_not @product2.save, 'price can not be blank.'
  end

  test 'price must be positive value' do
    @product.price = 0
    assert_not @product.save, 'price must be positive value.'
  end

  # Description Validation Testings
  test 'description can not be blank' do
    assert_not @product3.save, 'description can not be blank.'
  end

  test 'description minimum characters' do
    @product.description = 'a' * 9
    assert_not @product.save, 'description must have minimum 10 characters.'
  end

  test 'description maximum characters' do
    @product.description = 'a' * 201
    assert_not @product.save, 'description can have maximum 200 characters.'
  end
end
