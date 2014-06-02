require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  
  fixtures :products 

  def setup
  	@product = Product.new(title:       "My Book Title",
  		                   description: "yyy",
  		                   image_url:   "zzz.jpg",
  		                   price:       10.75)
  end

  test "product attributes must not be empty" do
  	product = Product.new
  	assert product.invalid?
  	assert product.errors[:title].any?
  	assert product.errors[:description].any?
  	assert product.errors[:price].any?
  	assert product.errors[:image_url].any?
  end

  test "product price must be positive" do 
  	@product.price = -1
  	assert @product.invalid?
  end

  test "product price must be >= 0.01" do 
  	@product.price = 0
  	assert @product.invalid?
  	@product.price = 0.01
  	assert @product.valid?
  end

  test "image url" do
  	ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.jpg }
  	bad = %w{ fred.doc fred.gif/more fred.gif.more fred.giffy }

    ok.each do |name|
      @product.image_url = name
      assert @product.valid?, "#{name} should be valid"
  	end

    bad.each do |name|
      @product.image_url = name
      assert @product.invalid?, "#{name} should be invalid"
    end
  end

  test "product title must be unique" do 
    @product.title = products(:ruby).title
    assert !@product.save
  end

  test "product title must be at least 10 characters" do
    @product.title = "Less char"
    assert @product.invalid?
    @product.title = "Equal char"
    assert @product.valid?
  end
end
