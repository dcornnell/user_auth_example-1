class UsersController < ApplicationController
	skip_filter :ensure_logged_in, only: [:new, :create]

	def new
		@new_user = User.new
	end

	def create
		@new_user = User.new(user_params)
		if @new_user.save
			redirect_to login_path, notice: "You signed up!"
		else
			render :new, notice: "You failed."
		end
	end

	def search
		@search = params[:search]
		@response_user = HTTParty.get("https://openapi.etsy.com/v2/users?keywords=#{@search["search"]}&limit=#{@search["number"]}&api_key=#{Rails.application.secrets.etsy_api_key}")
		@user = @response_user["results"]
		puts '___________________________'
		puts @search["search"]
		puts @user
		render :index 
	end

	private

	def user_params
		params.require(:user).permit!
	end
end