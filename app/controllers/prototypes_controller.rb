class PrototypesController < ApplicationController
  # アクションコントローラー
  before_action :set_prototype, except: [:index, :new, :create]
  # authenticate_user!を用いて制限を設けた（onlyまたはexceptオプションを用いて特定のアクションのみを指定する）
  before_action :authenticate_user!, except: [:index, :show]
  before_action :contributor_confirmation, only: [:edit, :update, :destroy]

  def index
    # 全てのプロトタイプの情報を代入
    @prototypes = Prototype.includes(:user)
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
     # データが保存されなかったときは詳細ページへ戻る
      render :new
    end
  end

  def show
   #  showアクションにインスタンス変数@commentsを定義し、
   # その投稿に紐づくすべてのコメントを代入するための記述をした
    @comment = Comment.new
    @comments = @prototype.comments
  end


  def edit
  end

  def update
    if @prototype.update(prototype_params)
      # 更新されたときはそのプロトタイプの詳細ページに戻る
      redirect_to prototype_path(@prototype)
    else
      # renderは、呼び出すビューファイルを指定するメソッド
      render :edit
    end
  end

  def destroy
    if @prototype.destroy
     #プロトタイプを削除したら、トップページに戻る
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def contributor_confirmation
    # 投稿者以外がeditアクションにアクセスしたらトップページにリダイレクトするように記述した
    redirect_to root_path unless current_user == @prototype.user
  end
end
