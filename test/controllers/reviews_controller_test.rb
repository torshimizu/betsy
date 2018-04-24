require "test_helper"

describe ReviewsController do
  describe 'create' do
    before do
      @old_review_count = Review.count
    end

    it 'is successful with valid data' do
      review_data = {
        rating: 5,
        product_id: Product.first.id
      }

      post reviews_path, params: {review: review_data}

      must_redirect_to product_path(Review.last.product.id)
      Review.count.must_equal @old_review_count + 1
    end

    it 'is unsuccessful with invalid data' do
      review_data = {
        rating: 7,
        product_id: Product.first.id
      }

      post reviews_path, params: {review: review_data}

      must_respond_with :redirect
      Review.count.must_equal @old_review_count
    end

  end
end
