module GithubCopier
  class GithubUtils
    class << self
      # List all repositories
      def list_all(opts = {})
        repos = []
        begin
          args = {
            per_page: opts[:per_page] || 100,
            all_repos: opts[:all_repos]
          }.merge!(opts)

          # If we are using :org then we must delete :user from the options
          if args[:org]
            args.merge!(org: opts[:org])
            args.delete(:user)
          else
            args.merge!(user: opts[:user])
            args.delete(:org)
          end

          # require this for only with org and with private repos
          args.merge!(oauth_token: args[:oauth_token]) if args[:oauth_token]

          # Only required if we use oauth_token which allow use to list private repositories
          github = Github.new(args)

          # List all repositories
          page = 1
          loop do
            args.merge!(page: page)

            list = github.repos.list(args)

            break if list.empty?
            page += 1
            repos << list.select do |r|
              if !args[:fork]
                r if !r['fork']
              else
                r
              end
            end
          end
          repos.flatten!
        rescue => e
          puts "Error getting getting repository for user/org #{e}"
          exit(1)
        end
      end

      # Clone list of repos of the following forms
      #
      # @params [Array<string>] projects list of project of the form '{org|user}/{language}/{repo_name}'
      #         [ "magnars/clojure/project1", "magnars/clojure/tools.macro", ...]
      # @param [String] base_dir the base directory to save the clone result
      #         default to current directory
      # The result will be saved to '/path/to/base_dir/{org_name}/{language}/{repo_name}'
      def clone_all(projects, base_dir = ".")
        base_path = File.expand_path(base_dir)

        FileUtils.mkdir_p(base_path)

        projects.each_with_index do |project, i|
          org_name, language, repo_name = project.split(File::SEPARATOR)

          # Note: need to cleanup the language like 'Emacs Lisp' to 'Emacs_Lisp' or 'emacs_lisp'
          language = FilenameCleaner.sanitize(language, '_', false)

          output_path = [base_path, org_name, language, repo_name].join(File::SEPARATOR)
          puts "Process #{i+1} of #{projects.size} => git clone git@github.com:#{[org_name, repo_name].join(File::SEPARATOR)}.git #{output_path}"
          # TODO: may be allow `https` as well as `git`?
          output = system("git clone git@github.com:#{[org_name, repo_name].join(File::SEPARATOR)}.git #{output_path} 2> /dev/null")
        end
      end

      def repos_as_list(repos)
        # Store the result in this list
        list = []
        repos.each do |k,v|
          v.each do |i|
            user_name, repo_name = i.split(File::SEPARATOR)
            list << [user_name, k, repo_name].join(File::SEPARATOR)
          end
        end
        list
      end

      # Map of repository by language
      #
      # Map language to list of repository
      # @return [Hash<String, Array<String>>] map of language to repos
      def repos_by_language(repos, languages)
        hash = {}
        languages.each do |l|
          hash[l] = repos.collect { |r| r['full_name'] if r['language'] == l }.compact
        end
        hash
      end
    end
  end
end
