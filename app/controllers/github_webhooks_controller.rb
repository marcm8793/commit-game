#TODO: Update this file to update the task status in real time
class GithubWebhooksController < ActionController::API
  include GithubWebhook::Processor

  def github_push(payload)
    Rails.logger.info "Received a push event: #{payload}"

    process_commits(payload['commits'], payload['repository']['html_url'], payload['ref'])
  end

  private

  def webhook_secret(payload)
    ENV['GITHUB_WEBHOOK_SECRET']
  end

  def process_commits(commits, repo_url, ref)
    commits.each do |commit|
      update_tasks(commit['message'], repo_url, ref)
    end
  end

  def update_tasks(commit_message, repo_url, ref)
    branch_name = ref.split('/').last
    project = Project.find_by(repo_url: repo_url)
    return unless project

    @task = Task.find_by(name: commit_message, arena_player: project.arena_player)
    return unless @task

    @task.update(done: true)
    redirect_to root_path
  end
end
