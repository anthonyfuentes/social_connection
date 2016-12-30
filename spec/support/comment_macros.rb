
module CommentMacros
  def create_comment(args = {})
    fill_in_comment_form(body: args.fetch(:body, 'comment body'))
    click_on 'Comment'
  end

  def fill_in_comment_form(args)
    fill_in('comment[body]', with: args.fetch(:body))
  end
end
