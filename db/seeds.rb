
def generate_genders(genders)
  genders.each do |gender|
    Gender.create!(name: gender)
  end
end

def create_admin_user
  User.create!(first_name: "First", last_name: "Last",
               email: "user@example.com",
               gender_id: 1,
               password: "password",
               profile: Profile.create,
               birthdate: Date.today)
end

def generate_n_users(n)
  n.times { User.create!(first_name: Faker::Name.first_name,
                        last_name: Faker::Name.last_name,
                        email: Faker::Internet.email,
                        gender_id: (rand(2) + 1),
                        profile: Profile.create,
                        birthdate: Date.today,
                        password: "password") }
end

def generate_n_posts_for(n, users)
  users.each do |user|
    create_n_posts_for(n, user)
  end
end

def create_n_posts_for(n, user)
  n.times { user.posts.create(body: Faker::Lorem.sentence) }
end

def generate_n_comments_for(n, commentables)
  commentables.each do |commentable|
    create_n_comments_for(n, commentable)
  end
end

def create_n_comments_for(n, commentable)
  comments = 0
  user_ids = User.pluck(:id)
  until comments == n || comments == User.count
    user_id = user_ids.sample
    commentable.comments << Comment.create!(body: Faker::Hacker.say_something_smart,
                                            commentable_id: commentable.id,
                                            commentable_type: commentable.class.name,
                                            user_id: user_id)
    comments += 1
  end
end

def generate_n_likes_for(n, likables)
  likables.each do |likable|
    create_n_likes_for(n, likable)
  end
end

def create_n_likes_for(n, likable)
  likes = 0
  users = User.all
  until likes == n || likes == User.count
    user = users.sample
    next if likable.likers.include?(user)
    likable.likes << Like.create(user: user)
    likes += 1
  end
end

generate_genders(["Gent", "Lady", "Secret"])

create_admin_user

generate_n_users(4)

generate_n_posts_for(5, User.all)

generate_n_comments_for(2, Post.all)

generate_n_likes_for(3, Post.all)

generate_n_likes_for(3, Comment.all)

puts "Generated #{ Gender.count } genders"
puts "Generated #{ User.count } users"
puts "Generated #{ Post.count } posts"
puts "Generated #{ Comment.count } comments"
puts "Generated #{ Like.count } likes"
