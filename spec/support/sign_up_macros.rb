
module SignUpMacros
  def fill_in_user_form(args)
    fill_in('user[first_name]', with: args.fetch(:first))
    fill_in('user[last_name]', with: args.fetch(:last))
    fill_in('user[email]', with: args.fetch(:email))
    fill_in('user[password]', with: args.fetch(:pw))
    fill_in('user[password_confirmation]', with: args.fetch(:pwc))
  end
end
