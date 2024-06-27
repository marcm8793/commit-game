class ProfilesController < ApplicationController
  def show
    @user = current_user
    client = Octokit::Client.new(access_token: ENV['GITHUB_ACCESS_TOKEN'])
    @github_user = client.user(@user.pseudo)
    @repos = client.repos(@user.pseudo)
    @events = client.user_events(@user.pseudo)
  rescue Octokit::NotFound
    flash[:alert] = "GitHub profile not found"
    redirect_to root_path
  end
end
