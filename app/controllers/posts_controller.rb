class PostsController < ApplicationController

  def index
    @posts = Post.page(params[:page])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      flash[:notice] = 'Post was successfully created.'
      redirect_to action: :index
    else
      render action: :new
    end

  end

  def update
  end

  def destroy
  end

  private

  def post_params

  end

end
