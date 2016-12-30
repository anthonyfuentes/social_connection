
module ApplicationHelper

  def brand_link
    if user_signed_in?
      destination = user_newsfeed_path(current_user)
    else
      destination = root_path
    end
    brand_link_to(destination)
  end

  private

  def brand_link_to(destination)
    link_to "Social Connection", destination,
      class: "navbar-brand"
  end

end
