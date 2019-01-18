class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
    commontator_thread_show(@post)
  end

  def new
    if cannot? :manage, Post
      redirect_to posts_path, danger: 'У вас нет прав на создание статьи'
    end
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post, success: 'Статья успешно создана'
    else
      render :new, danger: 'Ошибка при создании статьи'
    end
  end

  def edit
    if cannot? :manage, Post
      redirect_to posts_path, danger: 'У вас нет прав на редактирование статьи'
    end
  end

  def update
    if cannot? :manage, Post
      redirect_to posts_path, danger: 'У вас нет прав на изменение статьи'
    end
    if @post.update_attributes(post_params)
      redirect_to @post, notice: 'Статья успешно изменена'
    else
      render :edit, danger: 'Ошибка при изменении статьи'
    end
  end

  def destroy
    if cannot? :manage, Post
      redirect_to posts_path, danger: 'У вас нет прав на удаление статьи' and return
    end
    @post.destroy
    redirect_to posts_path, notice: 'Статья успешно удалена' and return
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :summary, :body, :image)
  end
end
