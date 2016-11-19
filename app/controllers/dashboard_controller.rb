class DashboardController < ApplicationController
  include ActionView::Helpers::UrlHelper

  before_action :set_current_user

  def index
    @callback_url = "#{ root_url }auth/auth0/callback"

    @intro = %{
Royal Icing lets you design and prototype directly from your content.

Content-first design is #{ link_to 'recommended', 'http://alistapart.com/blog/post/content-first-design' } by many leading design firms. [links]

Catalog text, images, records, and user stories, using familiar tools such as #hashtags.
    }
  end
end
