
module ProfileMacros
  def fill_in_profile_form(args)
    fill_in('profile[education]', with: args.fetch(:edu, ''))
    fill_in('profile[home_town]', with: args.fetch(:home, ''))
    fill_in('profile[current_town]', with: args.fetch(:current, ''))
    fill_in('profile[phone_number]', with: args.fetch(:phone, ''))
    fill_in('profile[words_to_live_by]', with: args.fetch(:quote, ''))
    fill_in('profile[about_me]', with: args.fetch(:about, ''))
  end
end
