class StaticPagesController < ApplicationController
  def home
    return unless logged_in?
    @micropost = current_user.microposts.build if logged_in?
    @feed_items = current_user.feed.page params[:page]
  end

  def help; end

  def about; end

  def contact; end
end
