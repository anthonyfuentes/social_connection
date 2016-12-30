
module PostMacros
  def create_post(args = {})
    fill_in_post_form(body: args.fetch(:body, 'post body'))
    click_on 'Post'
  end

  def fill_in_post_form(args)
    fill_in('post[body]', with: args.fetch(:body))
  end
end
