module Danger
  class Git
    attr_accessor :git

    def initialize(git = "git")
      @git = git
    end

    def pickupAuthors(file)
      stdout = system("#{git} log -n 10 --format='%an' -- #{file}")
    end
  end
end