namespace :notification do
  desc "Basic call and response"
  task :create, [:message] => [:environment] do |t, args|
    if args[:message]
      SendNotification.call(message: args[:message])
    else
      puts 'Gotta have a message bruv'
    end
  end
end
