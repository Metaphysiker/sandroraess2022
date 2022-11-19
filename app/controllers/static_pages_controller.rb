class StaticPagesController < ApplicationController
  def welcome

    @page_title       = 'Willkommen'
    @page_description = 'Willkommen'

    @articles = Article.all
  end

  def about_me
    set_meta_tags title: "Über mich",
              description: "Sandro Räss"
  end

  def contact
    set_meta_tags title: "Kontakt",
              description: "Kontakt"
  end

  def support

  end
end
