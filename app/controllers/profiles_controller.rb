class ProfilesController < ApplicationController
  def show
    @user = current_user
    client = Octokit::Client.new(access_token: ENV['GITHUB_ACCESS_TOKEN'])

    # Use cache_key_with_version for generating cache keys
    @github_user = fetch_github_user(client, @user)
    @repos = fetch_github_repos(client, @user).first(5)
    @events = fetch_github_events(client, @user)
    @commit_activity = fetch_commit_activity(client, @user)

  rescue Octokit::NotFound
    flash[:warning] = "GitHub profile not found"
    redirect_to root_path
  end

  private

  def fetch_github_user(client, user)
    Rails.cache.fetch("github_user/#{user.cache_key_with_version}", expires_in: 12.hours) do
      client.user(user.pseudo)
    end
  end

  def fetch_github_repos(client, user)
    Rails.cache.fetch("github_repos/#{user.cache_key_with_version}", expires_in: 12.hours) do
      client.repos(user.pseudo, sort: :created, direction: :desc)
    end
  end

  def fetch_github_events(client, user)
    Rails.cache.fetch("github_events/#{user.cache_key_with_version}", expires_in: 12.hours) do
      client.user_events(user.pseudo)
    end
  end

  def fetch_commit_activity(client, user)
    Rails.cache.fetch("commit_activity/#{user.cache_key_with_version}", expires_in: 12.hours) do
      repos = client.repos(user.pseudo)
      commit_counts = Hash.new(0)

      repos.each do |repo|
        begin
          stats = client.participation_stats("#{user.pseudo}/#{repo.name}")
          next if stats.nil? || stats.owner.nil?

          stats.owner.each_with_index do |count, index|
            date = (Date.today - (51 - index).weeks).beginning_of_week
            commit_counts[date] += count
          end
        rescue Octokit::Error
          next # Skip repositories that return an error
        end
      end

      # Sort the commit counts by date
      commit_counts.sort.to_h
    end
  end
end
