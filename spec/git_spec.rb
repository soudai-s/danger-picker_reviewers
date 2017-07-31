require File.expand_path('../spec_helper', __FILE__)

module Danger
  describe 'Git' do
    it 'Git has authors' do
      git = Git.new("git")
      expect(git.pickupAuthors('.gitignore')).to eq 'Pochi'
    end
  end
end

