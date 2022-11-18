class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]

  # GET /articles or /articles.json
  def index
    @articles = Article.all
  end

  # GET /articles/1 or /articles/1.json
  def show

    featured_image_url = @article.featured_image.attached? ? rails_blob_url(@article.featured_image) : ""

    set_meta_tags title: @article.title,
              description: @article.seo_description,
              og: {
                title: :title,
                description: :description,
                type:     'article',
                url:      article_url(@article),
                image:    featured_image_url,
            },
            article: {
              published_time:    @article.created_at.iso8601,
              modified_time:     @article.updated_at.iso8601,
            },
            twitter: {
              title: :title,
              description: :description,
              card:  "photo",
              image: {
                _:      featured_image_url
              }
            }



  end

  # GET /articles/new
  def new
    @article = Article.new
    authorize @article
  end

  # GET /articles/1/edit
  def edit
    authorize @article

  end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)
    authorize @article

    respond_to do |format|
      if @article.save
        format.html { redirect_to article_url(@article), notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    authorize @article

    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to article_url(@article), notice: "Article was successfully updated." }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    authorize @article

    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :sub_title, :content, :seo_description, :featured_image, :created_at)
    end
end
