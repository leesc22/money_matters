class ArticlesController < ApplicationController
	def index
		@news_api_articles = get_news_api.sample(3)
		@articles = Article.search(params[:search])
	end

	def show
		@article = Article.find(params[:id])
	end

	def edit
		@article = Article.find(params[:id])
	end

	def new
		@article = Article.new
	end

	def create
		url = article_params["url"]
		if url
			share_params = get_shared_article_params(url)
			if share_params
				@article = current_user.articles.new(share_params)
			else
				flash[:danger] = "Error creating article. Invalid link."
				return redirect_back(fallback_location: index_path)
			end
		else
			@article = current_user.articles.new(article_params)
		end

		if @article.save
			flash[:success] = "Article is created successfully."
			redirect_to @article
		else
			flash[:danger] = "Error creating article."
			render 'new'
		end
	end

	def update
		@article = Article.find(params[:id])
		if @article.update(article_params)
			flash[:success] = "Article is updated successfully."
			redirect_to @article
		else
			flash[:danger] = "Error updating article."
			render 'edit'
		end
	end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy
		respond_to do |format|
      format.html { redirect_to articles_path }
      format.js
    end
	end

	private

	def article_params
		params.require(:article).permit(:title, :content, :url, :image)
	end

	def get_shared_article_params(url)
		begin
			response = RestClient.get("http://link-thumbnailer-api.herokuapp.com/thumbnails/new\?url\=#{url}")
		rescue
			return
		else
			share_json = JSON.parse(response.body)
			img = share_json["images"].first
			{ url: share_json["url"], title: share_json["title"], content: share_json["description"], remote_image_url: (img["src"].to_s if img) }
		end
	end

	def get_news_api
		response = RestClient.get("https://newsapi.org/v1/articles?source=bloomberg&sortBy=top&apiKey=#{ENV['NEWS_API_KEY']}")
		news_json = JSON.parse(response.body)
		news_json["articles"]
	end
end
