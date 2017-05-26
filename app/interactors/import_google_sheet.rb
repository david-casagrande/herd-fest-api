require 'google_drive'

class ImportGoogleSheet
  include Interactor

  MAP = {
    bands: { model: Band, title: 'Herd Fest Bands', serializer: :serialize_band },
    venues: { model: Venue, title: 'Herd Fest Venues', serializer: :serialize_venue }
  }.freeze

  # context.type

  def call
    worksheet.rows.each_with_index do |row, idx|
      next if idx == 0
      data = send(serializer, row)
      data[:active] = true

      if row[0].empty?
        create_and_sync(idx, data)
      else
        #model.update(row[0], data)
      end
    end

    worksheet.save
  end

  private

  def create_and_sync(idx, data)
    r = model.create(data)
    worksheet[idx + 1, 1] = r.id
  end

  def session
    @session ||= GoogleDrive.saved_session('config.json')
  end

  def type
    @type ||= MAP[context.type]
  end

  def title
    @title ||= type[:title]
  end

  def serializer
    @serializer ||= type[:serializer]
  end

  def model
    @model ||= type[:model]
  end

  def worksheet
    @worksheet ||= session.spreadsheet_by_title(title).worksheets[0]
  end

  def serialize_band(row)
    {
      name: row[1],
      image_url: row[2],
      description: row[3],
      facebook_url: row[4],
      twitter_url: row[5]
    }
  end

  def serialize_venue(row)
    {
      name: row[1],
      street_address: row[2]
    }
  end
end
