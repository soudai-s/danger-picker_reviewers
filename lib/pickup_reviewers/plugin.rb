module Danger
  # This is your plugin class. Any attributes or methods you expose here will
  # be available from within your Dangerfile.
  #
  # To be published on the Danger plugins site, you will need to have
  # the public interface documented. Danger uses [YARD](http://yardoc.org/)
  # for generating documentation from your plugin source, and you can verify
  # by running `danger plugins lint` or `bundle exec rake spec`.
  #
  # You should replace these comments with a public description of your library.
  #
  # @example Ensure people are well warned about merging on Mondays
  #
  #          my_plugin.warn_on_mondays
  #
  # @see  soudai-s/danger-pickup_reviewers
  # @tags monday, weekends, time, rattata
  #
  class DangerPickupReviewers < Plugin

    # An attribute that you can read/write from your Dangerfile
    #
    # @return [String]
    attr_accessor :git_path

    def initialize(dangerfile)
      super(dangerfile)
      @git_path = ENV['GIT_PATH'] || 'git'
    end

    private

    def collaborators
      repo_name = github.pr_json[:base][:repo][:full_name]
      collaborators = github.api.collaborators(repo_name)
    end

    def update_files
      git.modified_files + git.created_files + git.deleted_files
    end

    def pickup_authors(file)
      stdout = system("#{git_path} log -n 10 --format='%an' -- #{file}")
    end

  end
end
