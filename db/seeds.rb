require 'faker'

# Create Users
users = []
10.times do
  users << User.create!(
    email: Faker::Internet.unique.email,
    password: "password",
    pseudo: Faker::Internet.username,
    avatar_url: Faker::Avatar.image,
  )
  puts "User created: #{users.last.email} - #{users.last.pseudo}"
end

# Create Arenas
arenas = []
5.times do
  arenas << Arena.create!(
    name: Faker::Esport.event,
    description: Faker::Lorem.paragraph,
    start_date: Faker::Date.backward(days: 30),
    end_date: Faker::Date.forward(days: 30),
    image_url: Faker::LoremFlickr.image,
    user: users.sample,
    prize: Faker::Number.number(digits: 4),
  )
  puts "Arena created: #{arenas.last.name}"
end

# Create Arena Players
arena_players = []
20.times do
  arena_players << ArenaPlayer.create!(
    user: users.sample,
    arena: arenas.sample,
    score: Faker::Number.between(from: 0, to: 100),
  )
  puts "Arena Player created: #{arena_players.last.user.email} - #{arena_players.last.arena.name} - #{arena_players.last.score}"
end

# Create Projects
projects = []
10.times do
  projects << Project.create!(
    arena_player: arena_players.sample,
    repo_url: Faker::Internet.url,
    name: Faker::App.name,
  )
  puts "Project created: #{projects.last.name}"
end

# Create Commits
30.times do
  Commit.create!(
    project: projects.sample,
  )
end

# Create Tasks
20.times do
  Task.create!(
    name: Faker::Verb.base,
    description: Faker::Lorem.paragraph,
    score: Faker::Number.between(from: 1, to: 10),
    week_number: Faker::Number.between(from: 1, to: 5),
    arena_player: arena_players.sample,
    done: Faker::Boolean.boolean,
  )
  puts "Task created: #{Task.last.name}"
end

puts "Seeding completed!"
