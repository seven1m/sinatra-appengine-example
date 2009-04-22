require 'fileutils'
require 'pathname'

directory 'lib'

desc 'Extracts the required parts of jruby-complete.jar (needs JRUBY_COMPLETE env).'
task :jrubyjars => ['lib'] do
  raise 'JRUBY_COMPLETE environment variable must be defined!' if ENV['JRUBY_COMPLETE'].nil?
  jruby_complete = Pathname.new(ENV['JRUBY_COMPLETE'])
  raise 'JRUBY_COMPLETE environment variable must be a file!' unless jruby_complete.file?
  jruby_complete = jruby_complete.realpath

  Dir.chdir 'lib' do
    make_empty_dir 'ruby-stdlib'
    make_empty_dir 'jruby-core'
    Dir.chdir 'ruby-stdlib' do
      sh 'jar', 'xf', jruby_complete
      FileUtils.mv %W(org com jline jay jruby), '../jruby-core'
      sh 'jar', 'cf', '../ruby-stdlib.jar', '.'
    end
    Dir.chdir 'jruby-core' do
      sh 'jar', 'cf', '../jruby-core.jar', '.'
    end
    FileUtils.rm_rf('ruby-stdlib', :secure => true)
    FileUtils.rm_rf('jruby-core', :secure => true)
  end
end

def make_empty_dir(dirname)
  FileUtils.rm_rf(dirname, :secure => true) if File.exist? dirname
  Dir.mkdir dirname
end
