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

  config.model 'Band' do
    edit do
      exclude_fields :venues
    end

    list do
      exclude_fields :id, :created_at, :updated_at, :venues
    end
  end

  config.model 'Venue' do
    edit do
      exclude_fields :bands
    end

    list do
      exclude_fields :id, :created_at, :updated_at, :bands
    end
  end

  config.model 'SetTime' do
    object_label_method do
      :set_time_object_label
    end

    list do
      exclude_fields :id, :created_at, :updated_at

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

  def set_time_object_label
    "#{default_date(self.date)} #{default_time(self.start_time)}"
  end

  def default_date(date)
    date.strftime('%D')
  end

  def default_time(time)
    time.strftime('%l:%M %p')
  end
end
