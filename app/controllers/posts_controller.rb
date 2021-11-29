class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create, :show, :update]
  before_action :set_post, only: [:show, :edit, :update, :destroy]


  def new
    authorize! :create, current_user
    @post = Post.new
  end

  def create
    authorize! :create, current_user
    @post = Post.new(posts_params)

    if @post.save
      redirect_to blog_index_path, notice: 'Post enviado com sucesso!'
    else
      redirect_to blog_index_path, alert: 'Erro ao enviar o post. Tente novamente mais tarde!'
    end
  end

  def edit
    authorize! :edit, current_user
  end

  def update
    authorize! :create, current_user

    if @post.update(posts_params)
      redirect_to blog_index_path, notice: 'Post atualizado com sucesso!'
    else
      redirect_to blog_index_path, alert: 'Erro ao atualizar post. Tente novamente mais tarde!'
    end
  end

  def show
    #if user_signed_in?
      @comment = Comment.new
    #else
    #  @comment = Comment.new

    #  if @comment.save!
    #    redirect_to request.referrer, notice: 'Comentário anônimo realizado com sucesso!'
    #  else
    #    redirect_to request.referrer, alert: 'Erro ao realizar comentário anônimo! Tente novamente mais tarde.'
    #  end
    #end
  end

  def destroy
    authorize! :delete, current_user

    if @post.delete
      redirect_to blog_index_path, notice: 'Post deletado com sucesso!'
    else
      redirect_to blog_index_path, alert: 'Erro ao deletar post. Tente novamente mais tarde!'
    end
  end

  private

  def posts_params
    params.require(:post).permit(:title, :content, :slug, :banner, :user_id)
  end

  def set_post
    @post = Post.friendly.find(params[:id])
  end
end
