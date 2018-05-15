class BlogsController < ApplicationController
  before_action :user_sign, except: [:index,:show]

  def index
    @blogs = Blog.all.page(params[:page]).per(5).order("created_at DESC")
  end

  def edit
      @blog = Blog.find(params[:id])
  end

  def destroy
    blog = Blog.find(params[:id])
    if blog.user_id == current_user.id
      blog.destroy
    end
  end

  def update
    if full_blog_contents?
      blog = Blog.find(params[:id])
      if blog.user.id == current_user.id
        blog.update(blog_params)
      end
    else
      redirect_to "/blogs/#{params[:id]}/edit", method: :get, alert:"＊項目を全て入力してください！"
    end
  end

  def new
  end

  def show
    @blog = Blog.find(params[:id])
  end

  def create
    if full_blog_contents?
      Blog.create(title: blog_params[:title], text: blog_params[:text], user_id: current_user.id)
    else
      redirect_to "/blogs/new", method: :get, alert:"＊項目を全て入力してください！"
    end

  end

  private
  def blog_params
    params.permit(:title, :text)
  end

  def user_sign
    unless user_signed_in?
      redirect_to action: :index
    end
  end

  def full_blog_contents?
    params[:text].present? && params[:title].present?
  end
end
