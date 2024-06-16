class RenameCachCopyToCatchCopyInPrototypes < ActiveRecord::Migration[7.0]
  def change
    rename_column :prototypes, :catch_copy, :catch_copy
  end
end#データベースに既に存在するテーブルのカラム名を変更するには、新しいマイグレーションを作成してrename_columnメソッドを使います：


#rails generate migration RenameCachCopyToCatchCopyInPrototypes

#生成されたマイグレーションファイルを開き、changeメソッドを以下のように変更します：


#def change
  #rename_column :prototypes, :catch_copy, :catch_copy
#end

#そしてマイグレーションを実行します：


#rails db:migrate
