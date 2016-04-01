require 'optparse'
require 'ostruct'
module GithubCopier
  class OptParser
    # Return a structure describing the options.
    def self.parse(args)
      # The options specified on the command line will be collected in *options*.
      # We set default values here.
      options = OpenStruct.new

      # The mandatory arguments
      options.base_dir = "."

      # The option arguments
      options.verbose = false

      # The parser
      opt_parser = OptionParser.new do |opts|
        opts.banner = "Usage: github_copier [options]"

        opts.separator ""
        opts.separator "Specific options:"

        # Mandatory argument
        opts.on("-b", "--base-dir BASE_DIR",
                "Output directory where the repository will be cloned to") do |dir|
          options.base_dir = dir
        end

        opts.on("-u", "--user USER",
                "The github USER that will be cloned from") do |user|
          # By default the id is assumed to be of a normal user not as organization
          options.user = user
        end

        opts.on("-o", "--org [ORG]",
                "The Github's organization name to be used if specified",
                "(where ORG is the organization that the user belongs to)") do |org|
          options.org = org
        end

        opts.on("-t", "--oauth-token [OAUTH_TOKEN]",
                "The Github's oauth_token for authentication (required to list/clone private repositories)",
                "(where OAUTH_TOKEN is from the user's Github setting)") do |token|
          options.oauth_token = token
        end

        opts.on("-l", "--language [LANG]",
                "Clone only project of type LANG",
                "(where LANG is main language as shown on Github)") do |lang|
          options.language = lang
        end

        # Boolean switch.
        opts.on("-a", "--[no-]all-repos",
                "All repository only (optional)",
                "(default to original/non-fork repositories only)") do |a|
          options.all_repos = a
        end

        opts.on( "-c", "--[no-]clone",
                "Clone the repositories to the path specified (optional)",
                "(default to --no-clone e.g. dry-run only)") do |c|
          options.clone_repos = c
        end

        opts.separator ""
        opts.separator "Common options:"

        # No argument, shows at tail.  This will print an options summary.
        # Try it and see!
        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end
      end

      opt_parser.parse!(args)
      options
    end
  end
end
