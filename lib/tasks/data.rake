require 'wombat'

namespace :data do
  desc 'generate list of some chill bands'
  task :buzz => :environment do
    puts 'killing all days...'
    Day.destroy_all
    puts 'new days dawn...'

    days = [
      Fabricate(:day, name: 'Thursday', date: '2015-06-11'),
      Fabricate(:day, name: 'Friday', date: '2015-06-12'),
      Fabricate(:day, name: 'Saturday', date: '2015-06-13'),
      Fabricate(:day, name: 'Sunday', date: '2015-06-14')
    ]

    puts Day.all.count

    puts 'bulldozing venues...'
    Venue.destroy_all
    puts 'venue up...'
    venue_data = Wombat.crawl do
      base_url 'http://www.songkick.com/metro_areas/22996-us-buffalo'
      path '/'

      venues({ css: '.venue-name a' }, :list)
    end

    venue_data['venues'].compact.uniq.map do |name|
      Fabricate(:venue, name: name)
    end
    puts Venue.all.count

    puts 'retiring all bands...'
    Band.destroy_all
    puts 'cant stop the buzz...'

    band_data = Wombat.crawl do
      base_url 'http://www.buffablog.com/calendar'
      path '/'

      bands({ css: '.wp-tiles-byline-title' }, :list)

      # venues 'xpath=//div[@class="wp-tiles-tile"][1]//a', :follow do
      #   heading 'css=h5:nth-of-type(2)'
      # end
    end


    band_data['bands'].compact.uniq.map do |name|
      Fabricate(:band, name: name)
    end

    puts Band.all.count

    puts 'where have all the set times gone'
    SetTime.destroy_all
    puts 'scheduling...'

    Venue.all.each do |venue|
      days.each do |day|
        Fabricate(:set_time, venue: venue, band: Band.order("RANDOM()").first, day: day, start_time: "22:00")
        Fabricate(:set_time, venue: venue, band: Band.order("RANDOM()").first, day: day, start_time: "23:00")
        Fabricate(:set_time, venue: venue, band: Band.order("RANDOM()").first, day: day, start_time: "00:00")
        Fabricate(:set_time, venue: venue, band: Band.order("RANDOM()").first, day: day, start_time: "01:00")
      end
    end

    puts SetTime.all.count
  end
end
