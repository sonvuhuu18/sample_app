class StaticPagesController < ApplicationController
  def home
    return unless logged_in?
    @micropost = current_user.microposts.build if logged_in?
    @feed_items = feeds.newest_first.page params[:page]
  end

  def help; end

  def about; end

  def contact; end

  private

  def feeds
    Micropost.feeds current_user.id
  end
end
