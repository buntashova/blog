class PostsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
	before_action :set_post, only: [ :show, :edit, :update, :destroy]

	def index
		@posts = Post.all
	end

	def show
	end

	def new
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
	end

	def update
		if @post.update_attributes(post_params)
			redirect_to @post, info: 'Статья успешно изменена'
		else
			render :edit, danger: 'Ошибка при изменении статьи'
		end
	end

	def destroy
		@post.destroy
		redirect_to posts_path, info: 'Статья успешно удалена'
	end

	private

	def set_post
		@post = Post.find(params[:id])
	end

	def post_params
		params.require(:post).permit(:title, :summary, :body)
	end
end
