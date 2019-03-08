class StaticPagesController < ApplicationController
  def home
  end

  def help
  end

  def about
  end

  def contact 
  end
  
end

 

# StaticPagesControllerがApplicationControllerというRailsのクラスを継承していることがわかる
# 今回コントローラにあるメソッドは空で純粋なRuby言語であればこれらのメソッドは何も実行しません
# しかし、Railsでは動作が異なる
# StaticPagesController はRubyのクラスですがApplicationControllerクラスを継承しているため、
# StaticPagesControllerのメソッドは (たとえ何も書かれていなくても) Rails特有の振る舞いをします。
# 具体的には、/static_pages/homeというURLにアクセスすると、RailsはStaticPagesコントローラを参照し、homeアクションに記述されているコードを実行します。