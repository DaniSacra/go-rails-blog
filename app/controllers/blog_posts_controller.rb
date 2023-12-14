class BlogPostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, except: [:index, :new, :create]

  def index
    @posts = BlogPost.all
  end

  def show
  end

  def new
    @post = BlogPost.new
  end

  def create
    post = BlogPost.new post_params
    if post.save
      redirect_to post
    else
      render :new, stauts: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @post.update post_params
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  private
    def post_params
      params.require(:blog_post).permit(:title, :body)
    end

    def set_post
      @post = BlogPost.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path
    end
end
