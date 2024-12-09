class ClinicsController < ApplicationController

  def new
    @clinics = Clinic.new
  end

  def index
    @clinics = Clinic.includes(:user)
  end

  
end
