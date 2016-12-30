
module SignInMacros
  def sign_in_as_new_user
    user = create(:user, :with_profile)
    sign_in(user: user)
    user
  end

  def sign_in(args)
    if user = args.fetch(:user, nil)
      user_sign_in(user, args)
    else
      credential_sign_in(args)
    end
  end

  def user_sign_in(user, args)
    args_to_pass = { email: user.email,
                     password: user.password }.merge(args)
    credential_sign_in(args_to_pass)
  end

  def credential_sign_in(args)
    visit root_path
    click_on('Sign In')
    fill_in('Email', with: args.fetch(:email))
    fill_in('sign-in-password', with: args.fetch(:password))
    click_on('Sign In')
  end
end
