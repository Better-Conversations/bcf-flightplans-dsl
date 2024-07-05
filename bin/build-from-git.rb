require 'tmpdir'

repo, revision, path, pdf_output = ARGV
if repo.nil? || revision.nil? || path.nil? || pdf_output.nil?
  puts "Usage: build-from-git.rb <repo> <revision> <path> <pdf_output>"
  exit 1
end

puts "Building from #{repo} at revision #{revision} with path #{path} to #{pdf_output}"

Dir.mktmpdir do |dir|
  puts "Cloning #{repo} to #{dir}"
  system("git clone #{repo} #{dir}")
  Dir.chdir(dir) do
    system("git checkout #{revision}")
    puts "Installing dependencies and running loader"
    system("bundle install")
    puts "Running loader"
    raise "TODO: Implement this!"
  end

  FileUtils.cp("#{dir}/output/output.pdf", pdf_output)
end
