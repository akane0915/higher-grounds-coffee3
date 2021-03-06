class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :index]

  before_action :only => [:new, :create, :edit, :update, :destroy] do
    redirect_to new_user_session_path unless current_user && current_user.admin
  end

  def index
    if params[:sort_by] == "highest_price"
      @products = Product.highest_price
      respond_to do |format|
        format.html { redirect_to products_path }
        format.js
      end
    else
      @products = Product.all
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @products = Product.all
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = "Product created."
      respond_to do |format|
        format.html { redirect_to products_path }
        format.js
      end
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product= Product.find(params[:id])
    if @product.update(product_params)
      flash[:notice] = "Product updated."
      respond_to do |format|
        format.html { redirect_to product_path(@product) }
        format.js
      end
    else
      render :edit
    end
  end

  def destroy
    Product.find(params[:id]).destroy
    flash[:notice] = "Product deleted."
    redirect_to products_path
  end

private
  def product_params
    params.require(:product).permit(:name, :description, :price, :image, :origin, :variety)
  end
end
