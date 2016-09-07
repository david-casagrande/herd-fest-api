namespace :notification do
  desc 'blast a message to all users'
  task :create, [:message] => [:environment] do |_, args|
    if args[:message]
      SendNotification.call(message: args[:message])
    else
      puts 'Gotta have a message bruv'
    end
  end

  desc 'send notification about show starting soon'
  task upcoming_shows: :environment do
    UpcomingSetTimes.call
  end
end
