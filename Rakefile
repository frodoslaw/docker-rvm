desc 'Cleans produced image'
task :clean do
	sh 'docker rmi -f frodoslaw/docker-rvm || true'
	sh 'docker images -q --filter "dangling=true" | xargs docker rmi || true'
end

desc 'Builds an image'
task :build do
	sh 'docker build -t frodoslaw/docker-rvm .'
end

task :default => [:clean, :build]
