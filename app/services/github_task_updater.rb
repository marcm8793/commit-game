require 'octokit'

class GithubTaskUpdater
  def initialize(repo_url, branch_name)
    @repo_url = repo_url
    @branch_name = branch_name
    @client = Octokit::Client.new(access_token: Rails.application.credentials.dig(:github, :access_token) || ENV['GITHUB_ACCESS_TOKEN'])
  end

  def update_tasks_to_done
    repo_name = extract_repo_name(@repo_url)
    commits = @client.commits(repo_name, @branch_name)
    commits.each do |commit|
      update_task_status(commit)
    end
  end

  private

  def extract_repo_name(repo_url)
    uri = URI.parse(repo_url)
    uri.path[1..-1].gsub('.git', '') # Remove leading slash and .git
  end

  def update_task_status(commit)
    task_name = extract_task_name(commit.commit.message)
    task = Task.find_by(name: task_name)
    return unless task

    task.update(done: true)
  end

  def extract_task_name(commit_message)
    # Extract the task name from the commit message
    commit_message.strip
  end
end
