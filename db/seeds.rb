require 'faker'

# Create Users
users = []
20.times do
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
4.times do
  arenas << Arena.create!(
    name: Faker::Esport.event,
    description: Faker::Lorem.paragraph,
    start_date: Faker::Date.backward(days: 30),
    end_date: Faker::Date.forward(days: 30),
    image_url: Faker::LoremFlickr.image,
    user: users.sample,
    prize: Faker::Number.number(digits: 4),
    active: [true, false].sample # Randomly set some arenas as active
  )
  puts "Arena created: #{arenas.last.name} - #{arenas.last.active}"
end

# Create Arena Players and Projects
arena_players = []
projects = []

arenas.each do |arena|
  selected_users = users.shuffle.take(5) # Select up to 5 users for each arena
  selected_users.each do |user|
    unless ArenaPlayer.exists?(user: user, arena: arena)
      player = ArenaPlayer.create!(
        user: user,
        arena: arena,
        score: Faker::Number.between(from: 0, to: 100)
      )
      arena_players << player
      puts "Arena Player created: #{player.user.email} - #{player.arena.name} - #{player.score}"

      # Create a project for each arena player
      project = Project.create!(
        arena_player: player,
        repo_url: Faker::Internet.url,
        name: Faker::App.name,
      )
      projects << project
      puts "Project created: #{project.name} for ArenaPlayer ID: #{player.id}"
    end
  end
end

# Create Commits
30.times do
  commit = Commit.create!(
    project: projects.sample,
  )
  puts "Commit created for Project ID: #{commit.project_id}"
end

# Create Tasks
20.times do
  task = Task.create!(
    name: Faker::Verb.base,
    description: Faker::Lorem.paragraph,
    score: Faker::Number.between(from: 1, to: 10),
    week_number: Faker::Number.between(from: 1, to: 5),
    arena_player: arena_players.sample,
    done: Faker::Boolean.boolean,
  )
  puts "Task created: #{task.name} for ArenaPlayer ID: #{task.arena_player_id}"
end

puts "Seeding completed!"
