class CacheFullSchedule
  include Interactor

  def call
    create_directory
    create_file
  rescue StandardError => e
    File.delete(file_path) if File.exist?(file_path)
    context.fail!(error: e)
  end

  private

  def create_directory
    Dir.mkdir(directory) unless File.directory?(directory)
  end

  def create_file
    full_schedule = GetFullSchedule.call(fresh: true)
    File.open(file_path, 'w') { |f| f.write(full_schedule.result.to_json) }
  end

  def directory
    ENV['JSON_CACHE_DIRECTORY']
  end

  def file_path
    Rails.root.join(directory, ENV['JSON_CACHE_FULL_SCHEDULE'])
  end
end
