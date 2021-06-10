class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end

  def new
    @reviews = Review.all
    @review = Review.new
    render :index
  end

  def create
    @review = Review.new(review_params)

    if @review.save
      redirect_to reviews_path
    else
      render :new
    end
  end

  def edit
    @reviews = Review.all
    @review = Review.find(params[:id])
    render :index
  end

  def update
  end



  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to reviews_path
  end

  private

  def review_params
    params.require(:review).permit(:name, :description, :photo)
  end
end
