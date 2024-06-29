class ProfilesController < ApplicationController
  def show
    @user = current_user
    client = Octokit::Client.new(access_token: ENV['GITHUB_ACCESS_TOKEN'])
    @github_user = client.user(@user.pseudo)
    @repos = client.repos(@user.pseudo, sort: :created, direction: :desc).first(5)
    @events = client.user_events(@user.pseudo)
    @commit_activity = fetch_commit_activity(client, @user.pseudo)

  rescue Octokit::NotFound
    flash[:warning] = "GitHub profile not found"
    redirect_to root_path
  end

  private

  def fetch_commit_activity(client, username)
    repos = client.repos(username)
    commit_counts = Hash.new(0)

    repos.each do |repo|
      begin
        stats = client.participation_stats("#{username}/#{repo.name}")
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
