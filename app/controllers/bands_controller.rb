class BandsController < ApplicationController
  def index
  end

  private

  def bands
    @bands ||= Band.all
  end
  helper_method :bands
end
