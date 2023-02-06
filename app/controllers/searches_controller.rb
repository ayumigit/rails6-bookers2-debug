class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]
    @word = params[:word]
    @user = current_user

    if @range == "User"
      @users = User.looks(params[:search], params[:word])
      render '/books/search_result'
    else
      @books = Book.looks(params[:search], params[:word])
      render '/books/search_result'
    end

  end
end
