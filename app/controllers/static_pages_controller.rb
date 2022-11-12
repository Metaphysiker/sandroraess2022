class StaticPagesController < ApplicationController
  def welcome
    @articles = Article.all
  end
end
