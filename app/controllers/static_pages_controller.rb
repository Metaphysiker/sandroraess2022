class StaticPagesController < ApplicationController
  def welcome

    @page_title       = 'Willkommen'
    @page_description = 'Willkommen'

    @articles = Article.all
  end

  def about_me

  end

  def contact

  end

  def support

  end
end
