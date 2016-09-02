RailsAdmin.config do |config|
  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.main_app_name = 'Herd Fest'

  config.authenticate_with do
    warden.authenticate! scope: :admin
  end
  config.current_user_method(&:current_admin)

  config.excluded_models = %w(Admin CacheStore)

  config.model 'Band' do
    edit do
      field :name
      field :description
      field :image_url
      field :facebook_url
      field :twitter_url
    end

    list do
      field :name
      field :description
    end
  end

  config.model 'Day' do
    edit do
      field :name
      field :date
    end

    list do
      field :name
      field :date
    end
  end

  config.model 'Venue' do
    edit do
      field :name
      field :street_address
    end

    list do
      field :name
      field :street_address
    end
  end

  config.model 'SetTime' do
    object_label_method do
      :set_time_object_label
    end

    edit do
      field :day
      field :band
      field :venue
      field :start_time
    end

    list do
      field :day
      field :band
      field :venue
      field :start_time do
        formatted_value do
          default_time(value)
        end

        pretty_value do
          default_time(value)
        end
      end
    end
  end

  config.model 'Device' do
    list do
      field :device_id
    end

    edit do
      exclude_fields :device_token, :device_id
    end

    show do
      exclude_fields :device_token
    end
  end

  def set_time_object_label
    default_time(start_time).to_s
  end

  def default_date(date)
    date.strftime('%D')
  end

  def default_time(time)
    time.strftime('%l:%M %p')
  end
end
