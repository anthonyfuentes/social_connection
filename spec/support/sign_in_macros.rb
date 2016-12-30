
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
    user_credentials = { email: user.email,
                         password: user.password }.merge(args)
    credential_sign_in(user_credentials)
  end

  def credential_sign_in(args)
    visit root_path
    within('header.navbar') do
      fill_in('Email', with: args.fetch(:email))
      fill_in('password', with: args.fetch(:password))
    end
    click_on('Sign In')
  end

end
