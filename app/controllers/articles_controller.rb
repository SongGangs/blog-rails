class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def new
    print 'new'
  end

  def edit
    @article = Article.find(params[:id])
  end

  def download
    @article = Article.find(params[:format])
    if @article == nil?
      render 'show'
    else
      file_path = @article.pdf_url
      # send_file file_path
      if File.exist?(file_path)
        io = File.open(file_path)
        io.binmode
        send_data(io.read, :filename => 'childs.pdf', :disposition => 'attachment')
        io.close
      else
        print '文件不存在'
        render 'show'
      end
    end
  end

  def preview
    @article = Article.find(params[:format])
    if @article == nil?
      render 'show'
    else
      binding.pry
      file_path = @article.pdf_url
      io = File.open(file_path)
      io.binmode
      #文档
      data = io.read
      io.close
      return data
    end
  end

  def create
    # 参数映射
    # render plain: params[:article].inspect
    # @article = Article.new(params[:article])
    @product = article_params
    # @article = Article.new(article_params)
    unless request.get?
      filename = uploadfile(@product[:pdf_url])
      if filename
        @product[:pdf_url] = filename

        @article = Article.new(@product)
        # binding.pry

        if @article.save
          redirect_to @article
        else
          render 'new'
        end
      else
        render 'new'
      end
    end
    # redirect_to search_path
  end

  def show
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

 def destroy
   @article = Article.find(params[:id])
   @article.destroy

   redirect_to articles_path
 end


  private

  def article_params
    params.require(:article).permit(:title, :text, :pdf_url)
  end

  def uploadfile(file)
    if !file.original_filename.empty?
      if file.content_type == 'application/pdf'
        @filename = file.original_filename
        #设置目录路径，如果目录不存在，生成新目录
        @pdf_path="#{Rails.root}/public/upload/#{Time.now.to_i}"
        FileUtils.mkdir(@pdf_path) unless File.exist?(@pdf_path)
        #写入文件
        ##wb 表示通过二进制方式写，可以保证文件不损坏
        File.open(@pdf_path + "/#{@filename}", 'wb') do |f|
          f.write(file.read)
        end
        return @pdf_path + "/#{@filename}"
      else
        print '文件格式不对'
        return nil
      end
    end
  end
end
