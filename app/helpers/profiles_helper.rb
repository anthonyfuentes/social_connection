module ProfilesHelper

  def edit_profile
    if current_user.id == params[:user_id].to_i
      link_to "Edit Profile", user_profile_edit_path(params[:user_id]),
                              class: "navbar-text navbar-link"
    end
  end
end
