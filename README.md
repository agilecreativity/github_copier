## GithubCopier

Export/clone Github repository (public/private) by user or organization name

[![Gem Version](https://badge.fury.io/rb/github_copier.svg)][gem]
[![Dependency Status](https://gemnasium.com/agilecreativity/github_copier.png)][gemnasium]
[![Code Climate](https://codeclimate.com/github/agilecreativity/github_copier.png)][codeclimate]

[gem]: http://badge.fury.io/rb/github_copier
[gemnasium]: https://gemnasium.com/agilecreativity/github_copier
[codeclimate]: https://codeclimate.com/github/agilecreativity/github_copier

### Why

- Be able to get grab all of interesting codes from a given user quickly
- Be able to clone specific language for a given user/organization
- Be able to clone all of organization/users in one go if desired
- Be able to clone private/public repositories for a given user/organization
- Be able to learn quickly or look at how something works from the source code
- I am too lazy to do this manually or through some other shell script

### Installation

```sh
# Install the gem
gem install github_copier

# refresh your gem just in case
rbenv rehash

# Get list of options just type the name of the gem
github_copier
```

You should see something like

```
Usage: github_copier [options]

Specific options:
    -b, --base-dir BASE_DIR          Output directory where the repository will be cloned to
    -u, --user USER                  The github USER that will be cloned from
    -o, --org [ORG]                  The Github's organization name to be used if specified
                                     (where ORG is the organization that the user belongs to)
    -t, --oauth-token [OAUTH_TOKEN]  The Github's oauth_token for authentication (required to list/clone private repositories)
                                     (where OAUTH_TOKEN is from the user's Github setting)
    -l, --language [LANG]            Clone only project of type LANG
                                     (where LANG is main language as shown on Github)
    -a, --[no-]all-repos             All repository only (optional)
                                     (default to original/non-fork repositories only)
    -c, --[no-]clone                 Clone the repositories to the path specified (optional)
                                     (default to --no-clone e.g. dry-run only)

Common options:
    -h, --help                       Show this message
```

- List repositories by user or organization id

```sh
# List all original/non-forked repositories by `awesome_user`
$github_copier --user awesome_user

## List all original/non-forked repositories of a user `awesome_user` that belongs to `AwesomeCo`
$github_copier --user awesome_user --org AwesomeCo

## List all origina/non-forked repositories by user `awesome_user` including private repository
# Note: for this to work you will need to have the proper access with the right token
$github_copier --user awesome_user --oauth-token GITHUB_TOKEN_FOR_THIS_USER

## List all repositories by user `awesome_user` include forked repositories
$github_copier --user awesome_user --oauth-token GITHUB_TOKEN_FOR_THIS_USER
```

- List and clone repositories by user or organization id using `--clone` option

```sh
## Clone all original (non-fork) public `JavaScript` repositores for user `awesome_user` to `~/Desktop/github`
# Note: --base-dir is optional, if not specified then the current directory will be used
#       --language must be quoted if the value include any spaces e.g. "Emacs Lisp" for this to to work properly
$github_copier --user awesome_user \
               --base-dir ~/Desktop/github \
               --language "JavaScript" \
               --clone

## Clone all public/private repositories for `awesome_user` which are member of `AwesomeCo` organization to `~/Desktop/github`
# Note: the option `--all` to include all forked repositories
$github_copier --user awesome_user \
               --org AwesomeCo \
               --all-repos \
               --base-dir ~/Desktop/github \
               --oauth-token GITHUB_TOKEN_FOR_AWESOME_USER \
               --clone

## Clone specific type of project (e.g. `Java` in this case) public/private repositories for `awesome_user`
## which are member of `AwesomeCo` organization to `~/Desktop/github`
$github_copier --user awesome_user \
               --org AwesomeCo \
               --all-repos \
               --language "Java" \
               --base-dir ~/Desktop/github \
               --oauth-token GITHUB_TOKEN_FOR_AWESOME_USER \
               --clone
```

### Example Sessions

- List repositories by a given user (dry-run)

```
# Dry run option (list only)
$github_copier -b ~/Desktop/projects -u littlebee -l CoffeeScript
------------------------------------------
List of languages by littlebee
Makefile
CoffeeScript
Ruby
JavaScript
Arduino
------------------------------------------
------------------------------------------
List of all repositories by littlebee
1/15: littlebee/Makefile/arduino-mk
2/15: littlebee/CoffeeScript/bumble-build
3/15: littlebee/CoffeeScript/bumble-docs
4/15: littlebee/CoffeeScript/bumble-strings
5/15: littlebee/CoffeeScript/bumble-test
6/15: littlebee/CoffeeScript/bumble-util
7/15: littlebee/CoffeeScript/git-log-utils
8/15: littlebee/CoffeeScript/git-status-utils
9/15: littlebee/CoffeeScript/git-time-machine
10/15: littlebee/CoffeeScript/notjs
11/15: littlebee/CoffeeScript/publish
12/15: littlebee/CoffeeScript/react-focus-trap-amd
13/15: littlebee/Ruby/got
14/15: littlebee/JavaScript/selectable-collection
15/15: littlebee/Arduino/solar-sunflower
------------------------------------------
Dry-run only, no action taken!
```

- List and clone repositories for a given user

```
# run option (list only)
$github_copier -b ~/Desktop/projects -u littlebee -l CoffeeScript -c
 github_copier git:(master) ✗ github_copier -b ~/Desktop/projects -u littlebee -l CoffeeScript -c
 ------------------------------------------
 List of languages by littlebee
 Makefile
 CoffeeScript
 Ruby
 JavaScript
 Arduino
 ------------------------------------------
 ------------------------------------------
 List of all repositories by littlebee
 1/15: littlebee/Makefile/arduino-mk
 2/15: littlebee/CoffeeScript/bumble-build
 3/15: littlebee/CoffeeScript/bumble-docs
 4/15: littlebee/CoffeeScript/bumble-strings
 5/15: littlebee/CoffeeScript/bumble-test
 6/15: littlebee/CoffeeScript/bumble-util
 7/15: littlebee/CoffeeScript/git-log-utils
 8/15: littlebee/CoffeeScript/git-status-utils
 9/15: littlebee/CoffeeScript/git-time-machine
 10/15: littlebee/CoffeeScript/notjs
 11/15: littlebee/CoffeeScript/publish
 12/15: littlebee/CoffeeScript/react-focus-trap-amd
 13/15: littlebee/Ruby/got
 14/15: littlebee/JavaScript/selectable-collection
 15/15: littlebee/Arduino/solar-sunflower
 ------------------------------------------
 Process 1 of 11 => git clone git@github.com:littlebee/bumble-build.git /Users/bchoomnuan/Desktop/projects/littlebee/CoffeeScript/bumble-build
 Process 2 of 11 => git clone git@github.com:littlebee/bumble-docs.git /Users/bchoomnuan/Desktop/projects/littlebee/CoffeeScript/bumble-docs
 Process 3 of 11 => git clone git@github.com:littlebee/bumble-strings.git /Users/bchoomnuan/Desktop/projects/littlebee/CoffeeScript/bumble-strings
 Process 4 of 11 => git clone git@github.com:littlebee/bumble-test.git /Users/bchoomnuan/Desktop/projects/littlebee/CoffeeScript/bumble-test
 Process 5 of 11 => git clone git@github.com:littlebee/bumble-util.git /Users/bchoomnuan/Desktop/projects/littlebee/CoffeeScript/bumble-util
 Process 6 of 11 => git clone git@github.com:littlebee/git-log-utils.git /Users/bchoomnuan/Desktop/projects/littlebee/CoffeeScript/git-log-utils
 Process 7 of 11 => git clone git@github.com:littlebee/git-status-utils.git /Users/bchoomnuan/Desktop/projects/littlebee/CoffeeScript/git-status-utils
 Process 8 of 11 => git clone git@github.com:littlebee/git-time-machine.git /Users/bchoomnuan/Desktop/projects/littlebee/CoffeeScript/git-time-machine
 Process 9 of 11 => git clone git@github.com:littlebee/notjs.git /Users/bchoomnuan/Desktop/projects/littlebee/CoffeeScript/notjs
 Process 10 of 11 => git clone git@github.com:littlebee/publish.git /Users/bchoomnuan/Desktop/projects/littlebee/CoffeeScript/publish
 Process 11 of 11 => git clone git@github.com:littlebee/react-focus-trap-amd.git /Users/bchoomnuan/Desktop/projects/littlebee/CoffeeScript/react-focus-trap-amd
```

### TODO

- Make only organization/user mandatory but not both at the same time
- Replace system call with the ruby library like [grit](https://github.com/mojombo/grit) or something similar

### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[Thor]: https://github.com/erikhuda/thor
[Minitest]: https://github.com/seattlerb/minitest
[RSpec]: https://github.com/rspec
[Guard]: https://github.com/guard/guard
[Yard]: https://github.com/lsegal/yard
[Pry]: https://github.com/pry/pry
[Rubocop]: https://github.com/bbatsov/rubocop
