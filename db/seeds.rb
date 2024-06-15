require 'faker'

puts "------------------------"
puts "--- Seeding Database ---"
puts "---- Creating Users-----"
users = []
users << User.create!(
  email: "michelle.mabelle@mail.com",
  password: "password",
  pseudo: "Michellelette",
  avatar_url: Faker::Avatar.image,
)
puts "User created: #{users.last.email} - #{users.last.pseudo}"

19.times do
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
  start_date = Faker::Date.backward(days: 15)
  end_date = start_date + 5.weeks
  arenas << Arena.create!(
    name: Faker::Esport.event,
    description: Faker::Lorem.paragraph,
    start_date: start_date,
    end_date: end_date,
    image_url: Faker::LoremFlickr.image,
    user: users.sample,
    prize: Faker::Number.number(digits: 4),
    active: true
  )
  puts "Arena created: #{arenas.last.name} - #{arenas.last.active}"
end

# Create Arena Players and Projects
arena_players = []
projects = []

# Ensure each user is an ArenaPlayer and distribute them across the arenas
users.shuffle.each_with_index do |user, index|
  arena = arenas[index % arenas.length]
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

  # Create tasks for each week for the arena player
  (1..5).each do |week|
    task = Task.create!(
      name: Faker::Verb.base,
      description: Faker::Lorem.paragraph,
      score: Faker::Number.between(from: 1, to: 10),
      week_number: week,
      arena_player: player,
      done: Faker::Boolean.boolean,
    )
    puts "Task created: #{task.name} for ArenaPlayer ID: #{task.arena_player_id} - Week #{week}"
  end
end

# Ensure each arena has exactly 5 ArenaPlayers
arenas.each do |arena|
  current_arena_players = arena.arena_players.count
  additional_players_needed = 5 - current_arena_players
  if additional_players_needed > 0
    additional_users = (users - arena.users).shuffle.take(additional_players_needed)
    additional_users.each do |user|
      player = ArenaPlayer.create!(
        user: user,
        arena: arena,
        score: Faker::Number.between(from: 0, to: 100)
      )
      arena_players << player
      puts "Additional Arena Player created: #{player.user.email} - #{player.arena.name} - #{player.score}"

      # Create a project for each additional arena player
      project = Project.create!(
        arena_player: player,
        repo_url: Faker::Internet.url,
        name: Faker::App.name,
      )
      projects << project
      puts "Project created: #{project.name} for ArenaPlayer ID: #{player.id}"

      # Create tasks for each week for the additional arena player
      (1..5).each do |week|
        task = Task.create!(
          name: Faker::Verb.base,
          description: Faker::Lorem.paragraph,
          score: Faker::Number.between(from: 1, to: 10),
          week_number: week,
          arena_player: player,
          done: Faker::Boolean.boolean,
        )
        puts "Task created: #{task.name} for ArenaPlayer ID: #{task.arena_player_id} - Week #{week}"
      end
    end
  end
end

# Create additional random Commits
30.times do
  commit = Commit.create!(
    project: projects.sample,
  )
  puts "Commit created for Project ID: #{commit.project_id}"
end

puts "Seeding completed!"
