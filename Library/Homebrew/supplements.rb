#!/usr/bin/ruby
abort "Usage: #{$0} package" unless ARGV[0]

def easy arg=ARGV[0]; return "easy_install #{arg}"; end
def cpan arg=ARGV[0]; return "cpan -i #{arg}"; end
def gem  arg=ARGV[0]; return "gem install #{arg}"; end

def command
  case ARGV[0]
    when 'rename' then cpan 'File::Rename'
    when 'mercurial','hg' then easy
    else 
      puts "Unknown package: #{ARGV[0]}"
      exit 1
  end
end


puts <<-sput
You can install #{ARGV[0]} using the following command:

    #{command}

CPAN, RubyGems and EasyInstall install to /usr. You can force them to install
to your HomeBrew prefix by following the instructions at
http://github.com/mxcl/homebrew/wiki

sput