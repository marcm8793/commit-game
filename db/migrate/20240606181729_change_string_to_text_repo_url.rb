class ChangeStringToTextRepoUrl < ActiveRecord::Migration[7.1]
  def change
    change_column :projects, :repo_url, :text
  end
end
