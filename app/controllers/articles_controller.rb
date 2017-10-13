class ArticlesController < ApplicationController
	def index
		@articles = Article.all
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
				@article = Article.new(share_params)
			else
				flash[:danger] = "Error creating article. Invalid link."
				return redirect_back(fallback_location: index_path)
			end
		else
			@article = Article.new(article_params)
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
		redirect_to articles_path
	end

	private

	def article_params
		params.require(:article).permit(:title, :content, :url)
	end

	def get_shared_article_params(url)
		begin
			response = RestClient.get("http://link-thumbnailer-api.herokuapp.com/thumbnails/new\?url\=#{url}")
		rescue
			return
		else
			share_json = JSON.parse(response.body)
			img = share_json["images"].first
			{ url: share_json["url"], title: share_json["title"], content: share_json["description"], remote_image_url: img["src"].to_s }
		end
	end
end
