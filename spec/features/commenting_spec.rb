require "rails_helper"

feature "Commenting" do
  context "valid data provided" do
    it "allows a user to comment on their own posts" do
      user = sign_in_as_new_user
      visit user_timeline_path(user.id)
      create_post
      comment_body = "comment body"
      fill_in_comment_form(body: comment_body)
      expect{ click_on "Comment" }.to change(Comment, :count).by(1)
    end

    it "displays the new comment to the user\"s timeline" do
      user = sign_in_as_new_user
      visit user_timeline_path(user.id)
      create_post
      comment_body = "comment body"
      create_comment(body: comment_body)
      expect(page).to have_content(comment_body)
    end
  end

  context "comment has been created" do
    it "allows a user to delete a comment they have authored" do
    end
  end

  context "invalid data provided" do
    it "does not create comment" do
      user = sign_in_as_new_user
      visit user_timeline_path(user.id)
      create_post
      comment_body = ""
      fill_in_comment_form(body: comment_body)
      expect{ click_on "Comment" }.to change(Comment, :count).by(0)
    end

    it "provides an error message" do
      user = sign_in_as_new_user
      visit user_timeline_path(user.id)
      create_post
      create_comment(body: "")
      expect(page).to have_content("too short")
    end
  end
end
