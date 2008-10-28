require 'git-pair/author'

module GitPair
  class Commit
    def self.commit(message, *pair_abbrs)
      base_command = "git commit"

      authors = pair_abbrs.collect { |author| GitPair::Author.find_by_abbr(author) }
      
      args = []
      args << %Q(-m "#{message}") unless message.nil? || message.empty?
      args << %Q(--author="#{authors.join(', ')}") unless authors.empty?

      command = "#{base_command} #{args.join(' ')}"
      system(command)
      return $?
    end
  end
end
