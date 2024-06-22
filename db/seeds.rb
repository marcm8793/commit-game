require 'faker'

puts "------------------------"
puts "--- Seeding Database ---"
puts "---- Creating Users-----"

users_data = [
  { pseudo: "FlanBer", avatar_url: "https://avatars.githubusercontent.com/u/156293255?v=4", email: "vcourault@eswarm.fr", password: "password" },
  { pseudo: "marcm8793", avatar_url: "https://avatars.githubusercontent.com/u/139041349?v=4", email: "marcm9387@gmail.com", password: "password" },
  { pseudo: "Lucas-Dimarellis", avatar_url: "https://avatars.githubusercontent.com/u/156849911?v=4", email: "dimarellisl@gmail.com", password: "password" },
  { pseudo: "victorcariou1", avatar_url: "https://avatars.githubusercontent.com/u/156707766?v=4", email: "victorcariou0@gmail.com", password: "password" }
]

users = users_data.map do |user_data|
  user = User.create!(user_data)
  puts "User created: #{user.email} - #{user.pseudo}"
  user
end

25.times do
  user = User.create!(
    email: Faker::Internet.unique.email,
    password: "password",
    pseudo: Faker::Internet.username,
    avatar_url: Faker::Avatar.image
  )
  puts "User created: #{user.email} - #{user.pseudo}"
  users << user
end

puts "---- Creating Languages ----"

languages_data = [
  { name: "Ruby", image_url: "https://s1.qwant.com/thumbr/474x316/b/a/7ff15d7e2e35bf4aec0e046dc44df06dec79091f864c4fc736b0505dc6fe40/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.-FJrVe8XmA4pZmwY7uVY6wHaE8%26pid%3DApi&q=0&b=1&p=0&a=0" },
  { name: "JS", image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTAg2n68y5tSKqRK_tw4ioZHQGT7zi1Piutng&s" },
  { name: "Python", image_url: "https://s1.qwant.com/thumbr/474x318/a/8/417a2d78b2d6fdce60552672c1d5d3211b1fa41318e76c25b6d202a7d39f74/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.hicFMnjJf8GyP0sleHrTbAHaE-%26pid%3DApi&q=0&b=1&p=0&a=0" },
  { name: "C#", image_url: "https://s2.qwant.com/thumbr/474x266/4/a/a75e6d6e2ab009cca0c31135287b990079f883a08f639e5f0e5cb690803d4e/th.jpg?u=https://tse.mm.bing.net/th?id%3DOIP.lXTBTGCpfgSe2vtRk0fUFwHaEK%26pid%3DApi&q=0&b=1&p=0&a=0" },
  { name: "PHP", image_url: "https://www.iutbethune.org/wp-content/uploads/2022/10/PHP.jpg" },
  { name: "Java", image_url: "https://s2.qwant.com/thumbr/474x266/5/d/f85a15945073c685aa29ff3b9565306fa0fe75520f101744f68687f55e7dd3/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.-PpueYZ_g4I0noGF_QSgCAHaEK%26pid%3DApi&q=0&b=1&p=0&a=0" }
]

languages = languages_data.map do |language_data|
  language = Language.create!(language_data)
  puts "Language created: #{language.name}"
  language
end

categories_data = [
  { name: "Débutant" },
  { name: "Intermédiaire" },
  { name: "Expert" }
]

categories = categories_data.map do |category_data|
  category = Category.create!(category_data)
  puts "Category created: #{category.name}"
  category
end

puts "---- Creating Arenas ----"

arenas_data = [
  { name: "ESL_master", description: "test", start_date: "2024-09-07", end_date: "2024-10-12", image_url: languages.find { |lang| lang.name == "Ruby" }.image_url, user_id: users.find { |u| u.pseudo == "victorcariou1" }.id, slots: 4, prize: 100, active: true, language_id: languages.find { |lang| lang.name == "Ruby" }.id, category_id: categories.find { |cat| cat.name == "Débutant" }.id },
  { name: "Code_Coliseum", description: "test", start_date: "2024-10-19", end_date: "2024-11-23", image_url: languages.sample.image_url, user_id: users.sample.id, slots: 10, prize: 250, active: false, language_id: languages.sample.id, category_id: categories.find { |cat| cat.name == "Intermédiaire" }.id },
  { name: "Debugging_Dome", description: "test", start_date: "2024-10-26", end_date: "2024-11-30", image_url: languages.sample.image_url, user_id: users.sample.id, slots: 7, prize: 175, active: false, language_id: languages.sample.id, category_id: categories.find { |cat| cat.name == "Expert" }.id },
  { name: "Byte_Battlefield", description: "test", start_date: "2024-11-02", end_date: "2024-12-07", image_url: languages.sample.image_url, user_id: users.sample.id, slots: 8, prize: 200, active: false, language_id: languages.sample.id, category_id: categories.find { |cat| cat.name == "Débutant" }.id },
  { name: "Algorithm_Arena", description: "test", start_date: "2024-10-19", end_date: "2024-11-23", image_url: languages.sample.image_url, user_id: users.sample.id, slots: 4, prize: 100, active: false, language_id: languages.sample.id, category_id: categories.find { |cat| cat.name == "Intermédiaire" }.id },
  { name: "Syntax_Stadium", description: "test", start_date: "2024-11-02", end_date: "2024-12-07", image_url: languages.sample.image_url, user_id: users.sample.id, slots: 6, prize: 150, active: false, language_id: languages.sample.id, category_id: categories.find { |cat| cat.name == "Expert" }.id },
  { name: "Compile_Coliseum", description: "test", start_date: "2024-10-26", end_date: "2024-11-30", image_url: languages.sample.image_url, user_id: users.sample.id, slots: 5, prize: 125, active: false, language_id: languages.sample.id, category_id: categories.find { |cat| cat.name == "Débutant" }.id },
  { name: "Hacker_Hall", description: "test", start_date: "2024-10-26", end_date: "2024-11-30", image_url: languages.sample.image_url, user_id: users.sample.id, slots: 6, prize: 150, active: false, language_id: languages.sample.id, category_id: categories.find { |cat| cat.name == "Intermédiaire" }.id },
  { name: "Logic_Lair", description: "test", start_date: "2024-11-02", end_date: "2024-12-07", image_url: languages.sample.image_url, user_id: users.sample.id, slots: 8, prize: 200, active: false, language_id: languages.sample.id, category_id: categories.find { |cat| cat.name == "Expert" }.id },
  { name: "Terminal_Tower", description: "test", start_date: "2024-10-19", end_date: "2024-11-23", image_url: languages.sample.image_url, user_id: users.sample.id, slots: 5, prize: 125, active: false, language_id: languages.sample.id, category_id: categories.find { |cat| cat.name == "Débutant" }.id },
  { name: "Function_Forum", description: "test", start_date: "2024-11-02", end_date: "2024-12-07", image_url: languages.sample.image_url, user_id: users.sample.id, slots: 6, prize: 150, active: false, language_id: languages.sample.id, category_id: categories.find { |cat| cat.name == "Intermédiaire" }.id },
  { name: "Script_Sanctuary", description: "test", start_date: "2024-10-26", end_date: "2024-11-30", image_url: languages.sample.image_url, user_id: users.sample.id, slots: 8, prize: 200, active: false, language_id: languages.sample.id, category_id: categories.find { |cat| cat.name == "Expert" }.id },
  { name: "Variable_Vault", description: "test", start_date: "2024-11-02", end_date: "2024-12-07", image_url: languages.sample.image_url, user_id: users.sample.id, slots: 15, prize: 375, active: false, language_id: languages.sample.id, category_id: categories.find { |cat| cat.name == "Débutant" }.id },
  { name: "Pixel_Pit", description: "test", start_date: "2024-11-02", end_date: "2024-12-07", image_url: languages.sample.image_url, user_id: users.sample.id, slots: 5, prize: 125, active: false, language_id: languages.sample.id, category_id: categories.find { |cat| cat.name == "Intermédiaire" }.id },
  { name: "Data_Den", description: "test", start_date: "2024-10-26", end_date: "2024-11-30", image_url: languages.sample.image_url, user_id: users.sample.id, slots: 8, prize: 200, active: false, language_id: languages.sample.id, category_id: categories.find { |cat| cat.name == "Expert" }.id },
  { name: "Query_Quadrant", description: "test", start_date: "2024-11-02", end_date: "2024-12-07", image_url: languages.sample.image_url, user_id: users.sample.id, slots: 4, prize: 100, active: false, language_id: languages.sample.id, category_id: categories.find { |cat| cat.name == "Débutant" }.id },
  { name: "Binary_Bastion", description: "test", start_date: "2024-10-19", end_date: "2024-11-23", image_url: languages.sample.image_url, user_id: users.sample.id, slots: 8, prize: 200, active: false, language_id: languages.sample.id, category_id: categories.find { |cat| cat.name == "Intermédiaire" }.id },
  { name: "Stack_Fortress", description: "test", start_date: "2024-10-26", end_date: "2024-11-30", image_url: languages.sample.image_url, user_id: users.sample.id, slots: 20, prize: 500, active: false, language_id: languages.sample.id, category_id: categories.find { |cat| cat.name == "Expert" }.id },
  { name: "Module_Maze", description: "test", start_date: "2024-10-19", end_date: "2024-11-23", image_url: languages.sample.image_url, user_id: users.sample.id, slots: 8, prize: 200, active: false, language_id: languages.sample.id, category_id: categories.find { |cat| cat.name == "Débutant" }.id },
  { name: "Protocol_Plaza", description: "test", start_date: "2024-11-02", end_date: "2024-12-07", image_url: languages.sample.image_url, user_id: users.sample.id, slots: 10, prize: 250, active: false, language_id: languages.sample.id, category_id: categories.find { |cat| cat.name == "Intermédiaire" }.id },
  { name: "Code_Clash_Court", description: "test", start_date: "2024-10-19", end_date: "2024-11-23", image_url: languages.sample.image_url, user_id: users.sample.id, slots: 25, prize: 625, active: false, language_id: languages.sample.id, category_id: categories.find { |cat| cat.name == "Expert" }.id }
]

puts "---- Creating Arena Players and Projects ----"

arena_players = []
projects = []

arenas = arenas_data.map do |arena_data|
  arena = Arena.create!(arena_data)
  puts "Arena created: #{arena.name} - #{arena.active}"

  if arena.name == "ESL_master"
    first_arena_players_data = [
      { pseudo: "FlanBer", project_name: "TaDAH-Match", repo_url: "https://github.com/FlanBer/TaDAH-List" },
      { pseudo: "marcm8793", project_name: "flex-space", repo_url: "https://github.com/marcm8793/flex-space-app" },
      { pseudo: "Lucas-Dimarellis", project_name: "Stupid-Coaching", repo_url: "https://github.com/Lucas-Dimarellis/rails-stupid-coaching" },
      { pseudo: "victorcariou1", project_name: "Next-Social", repo_url: "https://github.com/victorcariou1/next-social" }
    ]

    first_arena_players_data.each do |player_data|
      user = User.find_by(pseudo: player_data[:pseudo])
      player = ArenaPlayer.create!(
        user: user,
        arena: arena,
        score: 0,
      )
      arena_players << player
      puts "Arena Player created: #{player.user.email} - #{player.arena.name} - #{player.score}"

      project = Project.create!(
        arena_player: player,
        repo_url: player_data[:repo_url],
        name: player_data[:project_name]
      )
      projects << project
      puts "Project created: #{project.name} for ArenaPlayer ID: #{player.id}"
    end

    first_arena_tasks_data = [
      { name: "Recherche produits", description: "Ajout de la fonctionnalité permettant aux utilisateurs de rechercher des produits par mots-clés et catégories.", score: 20, done: true, week_number: 1, user_pseudo: "Lucas-Dimarellis" },
      { name: "Correction bugs vendeurs", description: "Correction des problèmes d'affichage sur la page des vendeurs, incluant les images et les descriptions.", score: 15, done: false, week_number: 1, user_pseudo: "Lucas-Dimarellis" },
      { name: "Avis produits", description: "Implémentation du système de notation et d'avis pour les produits afin que les utilisateurs puissent laisser des feedbacks.", score: 25, done: true, week_number: 2, user_pseudo: "Lucas-Dimarellis" },
      { name: "Optimisation filtres", description: "Amélioration des performances des filtres de recherche pour une expérience utilisateur plus fluide et rapide.", score: 20, done: true, week_number: 2, user_pseudo: "Lucas-Dimarellis" },
      { name: "Tests commandes", description: "Ajout des tests unitaires pour le processus de commande afin d'assurer la fiabilité et la stabilité.", score: 20, done: false, week_number: 3, user_pseudo: "Lucas-Dimarellis" },
      { name: "Refactorisation stocks", description: "Refactorisation du module de gestion des stocks pour une meilleure lisibilité et maintenabilité du code.", score: 15, done: true, week_number: 3, user_pseudo: "Lucas-Dimarellis" },
      { name: "Messagerie utilisateurs", description: "Implémentation du système de messagerie permettant aux acheteurs et aux vendeurs de communiquer directement.", score: 25, done: true, week_number: 4, user_pseudo: "Lucas-Dimarellis" },
      { name: "Correction accueil", description: "Correction des problèmes de mise en page sur la page d'accueil pour une meilleure présentation visuelle.", score: 10, done: false, week_number: 4, user_pseudo: "Lucas-Dimarellis" },
      { name: "Mise à jour CGV", description: "Mise à jour des conditions générales de vente pour inclure les nouvelles politiques de retour et de remboursement.", score: 10, done: false, week_number: 5, user_pseudo: "Lucas-Dimarellis" },
      { name: "Suivi commandes", description: "Ajout de la fonctionnalité permettant aux utilisateurs de suivre l'état de leurs commandes en temps réel.", score: 40, done: false, week_number: 5, user_pseudo: "Lucas-Dimarellis" },
      { name: "Fonctionnalité profil", description: "Ajout de la fonctionnalité permettant aux utilisateurs de créer et de personnaliser leurs profils, incluant les photos et les descriptions.", score: 20, done: true, week_number: 1, user_pseudo: "FlanBer" },
      { name: "Correction bugs messagerie", description: "Correction des bugs dans le système de messagerie, incluant les problèmes de notification et de livraison des messages.", score: 20, done: false, week_number: 1, user_pseudo: "FlanBer" },
      { name: "Implémentation match", description: "Implémentation de la fonctionnalité de match permettant aux utilisateurs de se connecter mutuellement s'ils s'apprécient.", score: 25, done: true, week_number: 2, user_pseudo: "FlanBer" },
      { name: "Optimisation algorithme", description: "Amélioration des performances de l'algorithme de recommandation pour proposer des profils plus pertinents aux utilisateurs.", score: 25, done: false, week_number: 2, user_pseudo: "FlanBer" },
      { name: "Tests filtres recherche", description: "Ajout des tests unitaires pour les filtres de recherche afin d'assurer leur bon fonctionnement et leur précision.", score: 20, done: false, week_number: 3, user_pseudo: "FlanBer" },
      { name: "Refactorisation utilisateurs", description: "Refactorisation du module de gestion des utilisateurs pour une meilleure organisation et une maintenance plus facile du code.", score: 15, done: false, week_number: 3, user_pseudo: "FlanBer" },
      { name: "Support notifications push", description: "Ajout du support pour les notifications push afin d'alerter les utilisateurs des nouveaux matchs et messages.", score: 20, done: true, week_number: 4, user_pseudo: "FlanBer" },
      { name: "Correction affichage photos", description: "Correction des problèmes d'affichage des photos dans les profils, assurant une présentation visuelle correcte et attrayante.", score: 10, done: false, week_number: 4, user_pseudo: "FlanBer" },
      { name: "Mise à jour conditions", description: "Mise à jour des conditions d'utilisation pour inclure les nouvelles politiques de confidentialité et les termes de service.", score: 10, done: false, week_number: 5, user_pseudo: "FlanBer" },
      { name: "Fonctionnalité super-like", description: "Ajout de la fonctionnalité super-like permettant aux utilisateurs de montrer un intérêt particulier pour un profil spécifique.", score: 35, done: false, week_number: 5, user_pseudo: "FlanBer" },
      { name: "Publication post", description: "Ajout de la fonctionnalité permettant aux utilisateurs de publier des posts, incluant du texte, des images et des vidéos.", score: 15, done: true, week_number: 1, user_pseudo: "victorcariou1" },
      { name: "Correction bugs commentaires", description: "Correction des bugs dans le système de commentaires, incluant les problèmes de notification et d'affichage des réponses.", score: 20, done: true, week_number: 1, user_pseudo: "victorcariou1" },
      { name: "Système amis", description: "Implémentation de la fonctionnalité de gestion des amis permettant aux utilisateurs d'envoyer et d'accepter des demandes d'amitié.", score: 20, done: true, week_number: 2, user_pseudo: "victorcariou1" },
      { name: "Optimisation flux", description: "Amélioration des performances du flux d'actualités pour afficher les posts de manière plus fluide et rapide.", score: 20, done: true, week_number: 2, user_pseudo: "victorcariou1" },
      { name: "Tests notifications", description: "Ajout des tests unitaires pour les notifications afin d'assurer leur bon fonctionnement et leur précision.", score: 20, done: true, week_number: 3, user_pseudo: "victorcariou1" },
      { name: "Refactorisation profils", description: "Refactorisation du module de gestion des profils pour une meilleure organisation et une maintenance plus facile du code.", score: 15, done: true, week_number: 3, user_pseudo: "victorcariou1" },
      { name: "Support vidéos", description: "Ajout du support pour les vidéos permettant aux utilisateurs de partager et visionner des vidéos sur la plateforme.", score: 25, done: true, week_number: 4, user_pseudo: "victorcariou1" },
      { name: "Suggestions amis IA", description: "Ajout de la fonctionnalité de suggestions d'amis basée sur l'IA, recommandant des amis potentiels en fonction des intérêts et des interactions des utilisateurs.", score: 45, done: false, week_number: 4, user_pseudo: "victorcariou1" },
      { name: "Mise à jour conditions", description: "Mise à jour des conditions d'utilisation pour inclure les nouvelles politiques de confidentialité et les termes de service.", score: 10, done: false, week_number: 5, user_pseudo: "victorcariou1" },
      { name: "Correction affichage images", description: "Correction des problèmes d'affichage des images dans les posts, assurant une présentation visuelle correcte et attrayante.", score: 10, done: false, week_number: 5, user_pseudo: "victorcariou1" },
      { name: "Gestion portefeuille", description: "Ajout de la fonctionnalité permettant aux utilisateurs de gérer leurs portefeuilles, y compris la visualisation des soldes et l'historique des transactions.", score: 25, done: true, week_number: 1, user_pseudo: "marcm8793" },
      { name: "Correction bugs transaction", description: "Correction des bugs liés à l'exécution des transactions, incluant les erreurs de validation et de confirmation.", score: 20, done: true, week_number: 1, user_pseudo: "marcm8793" },
      { name: "Implémentation staking", description: "Implémentation de la fonctionnalité de staking permettant aux utilisateurs de verrouiller des tokens pour gagner des récompenses.", score: 30, done: true, week_number: 2, user_pseudo: "marcm8793" },
      { name: "Optimisation appels RPC", description: "Amélioration des performances des appels RPC pour une interaction plus rapide avec la blockchain Solana.", score: 20, done: false, week_number: 2, user_pseudo: "marcm8793" },
      { name: "Tests smart contracts", description: "Ajout des tests unitaires pour les smart contracts afin d'assurer leur bon fonctionnement et leur sécurité.", score: 25, done: true, week_number: 3, user_pseudo: "marcm8793" },
      { name: "Refactorisation comptes", description: "Refactorisation du module de gestion des comptes pour une meilleure organisation et une maintenance plus facile du code.", score: 15, done: true, week_number: 3, user_pseudo: "marcm8793" },
      { name: "Support tokens SPL", description: "Ajout du support pour les tokens SPL, permettant aux utilisateurs de gérer divers types de tokens sur la plateforme.", score: 20, done: true, week_number: 4, user_pseudo: "marcm8793" },
      { name: "Correction affichage solde", description: "Correction des problèmes d'affichage des soldes dans l'interface utilisateur, assurant une mise à jour précise et en temps réel.", score: 10, done: true, week_number: 4, user_pseudo: "marcm8793" },
      { name: "Mise à jour documentation", description: "Mise à jour de la documentation de l'API pour inclure les nouvelles fonctionnalités et améliorer la clarté des instructions.", score: 10, done: false, week_number: 5, user_pseudo: "marcm8793" },
      { name: "Fonctionnalité swap", description: "Ajout de la fonctionnalité de swap permettant aux utilisateurs d'échanger différents tokens directement via la plateforme.", score: 25, done: false, week_number: 5, user_pseudo: "marcm8793" }
    ]

    first_arena_tasks_data.each do |task_data|
      user = User.find_by(pseudo: task_data[:user_pseudo])
      player = ArenaPlayer.find_by(user: user, arena: arena)
      task = Task.create!(
        name: task_data[:name],
        description: task_data[:description],
        score: task_data[:score],
        done: task_data[:done],
        week_number: task_data[:week_number],
        arena_player: player
      )
      puts "Task created: #{task.name} for ArenaPlayer ID: #{task.arena_player_id} - Week #{task.week_number}"
    end
  end

  arena
end

puts "Creating additional random Commits..."

30.times do
  commit = Commit.create!(
    project: projects.sample
  )
  puts "Commit created for Project ID: #{commit.project_id}"
end

puts "Seeding completed!"



# # Ensure each user is an ArenaPlayer and distribute them across the arenas
# users.shuffle.each_with_index do |user, index|
#   arena = arenas[index % arenas.length]
#   player = ArenaPlayer.create!(
#     user: user,
#     arena: arena,
#     score: Faker::Number.between(from: 0, to: 100)
#   )
#   arena_players << player
#   puts "Arena Player created: #{player.user.email} - #{player.arena.name} - #{player.score}"

#   # Create a project for each arena player
#   project = Project.create!(
#     arena_player: player,
#     repo_url: Faker::Internet.url,
#     name: Faker::App.name,
#   )
#   projects << project
#   puts "Project created: #{project.name} for ArenaPlayer ID: #{player.id}"

#   # Create tasks for each week for the arena player
#   (1..5).each do |week|
#     task = Task.create!(
#       name: Faker::Verb.base,
#       description: Faker::Lorem.paragraph,
#       score: Faker::Number.between(from: 1, to: 10),
#       week_number: week,
#       arena_player: player,
#       done: Faker::Boolean.boolean,
#     )
#     puts "Task created: #{task.name} for ArenaPlayer ID: #{task.arena_player_id} - Week #{week}"
#   end
# end

# # Ensure each arena has exactly 5 ArenaPlayers
# arenas.each do |arena|
#   current_arena_players = arena.arena_players.count
#   additional_players_needed = 5 - current_arena_players
#   if additional_players_needed > 0
#     additional_users = (users - arena.users).shuffle.take(additional_players_needed)
#     additional_users.each do |user|
#       player = ArenaPlayer.create!(
#         user: user,
#         arena: arena,
#         score: Faker::Number.between(from: 0, to: 100)
#       )
#       arena_players << player
#       puts "Additional Arena Player created: #{player.user.email} - #{player.arena.name} - #{player.score}"

#       # Create a project for each additional arena player
#       project = Project.create!(
#         arena_player: player,
#         repo_url: Faker::Internet.url,
#         name: Faker::App.name,
#       )
#       projects << project
#       puts "Project created: #{project.name} for ArenaPlayer ID: #{player.id}"

#       # Create tasks for each week for the additional arena player
#       (1..5).each do |week|
#         task = Task.create!(
#           name: Faker::Verb.base,
#           description: Faker::Lorem.paragraph,
#           score: Faker::Number.between(from: 1, to: 10),
#           week_number: week,
#           arena_player: player,
#           done: Faker::Boolean.boolean,
#         )
#         puts "Task created: #{task.name} for ArenaPlayer ID: #{task.arena_player_id} - Week #{week}"
#       end
#     end
#   end
# end

# # Create additional random Commits
# 30.times do
#   commit = Commit.create!(
#     project: projects.sample,
#   )
#   puts "Commit created for Project ID: #{commit.project_id}"
# end

# puts "Seeding completed!"
