class PrototypesController < ApplicationController
  before_action :set_prototype, except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :contributor_confirmation, only: [:edit, :update, :destroy]
 
  def index
    @prototypes = Prototype.includes(:user)
  end
    
  def new
    @prototype = Prototype.new
  end

 def show
  @comments = @prototype.comments
  @comment = Comment.new
 end

#updateメソッドは、既存のプロトタイプの情報を更新すr
#prototype_paramsメソッドから取得した安全なパラメータを
#使ってプロトタイプを更新 更新が成功した場合、そのプロトタイプ
#の詳細画面にリダイレクト(redirect_to prototype_path(@prototype))。
#それに対して、更新が失敗した場合、編集画面を再レンダリング(render :edit)

def edit
end#あなたが必要としている機能は、すでに実装されているように見えます。set_prototypeというメソッドで、送られてきたIDの情報をもとに、Prototypeモデルの特定のオブジェクトを取得し、それを@prototypeに代入しています。
#そして、before_action :set_prototype, except: [:index, :new, :create]によって、index、new、createアクション以外のアクションが実行される前に、必ずset_prototypeが実行されます。これにより、editアクションなどを実行する際には、@prototypeが定義されます。
#ここでは何も書かれていませんが、before_actionによってこのアクションが呼ばれる前にset_prototypeが実行されます。そのため、editアクションが呼ばれたときにはすでに@prototypeが定義されてい
def update
  if @prototype.update(prototype_params)
    redirect_to prototype_path(@prototype), notice: 'Prototype was successfully updated.'
  else
    render :edit
  end
end

def destroy
  if @prototype.destroy
    redirect_to root_path
  else
    redirect_to prototypes_path, flash: { error: 'Failed to delete prototype' }
  end
end# destroy メソッドは、既存のプロトタイプを削除するために使用されます。@prototype.destroyが真(true)を返す場合、つまり削除が成功した場合も、削除が何らかの理由で失敗した場合も、いずれの状況でもユーザーはトップページ（root_pathが指すページ）にリダイレクト
  
  def create
    @prototype = Prototype.new(prototype_params)
    #prototype_paramsを使って新しいPrototypeのインスタンスを作成し、
    #それを@prototypeに割り当て.saveメソッドを使ってインスタンスを
    #データベースに保存しようとしている
    if @prototype.save
      redirect_to root_path, notice: 'Prototype was successfully created.'
    else #saveが成功すれば、ユーザーはルートパスへ
      render :new, status: :unprocessable_entity
      #失敗したら新規投稿ページが再上記のcreateアクションは、ポストの保存が失敗した場合(@post.saveがfalseを返す場合)、render :newで新規投稿ページを再描画ビューでは、入力フォーム(例えばform_with @post)に直接、@postインスタンスを引数として渡すその結果、保存に失敗した際には、renderによって再描画されるページで@postが引き続き読み込まれ、入力済みの情報がそのまま表示
    end
  end
   
  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)#current_user.id
    #:prototypeのパラメータを検証し、それが適切（必要な要素が含まれているか、
    #または許可された要素のみであるか）であることを確認し、そして特定の
    #(current_user.id)ユーザーに関連付ける
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def contributor_confirmation
    redirect_to root_path unless current_user == @prototype.user
  end

end
