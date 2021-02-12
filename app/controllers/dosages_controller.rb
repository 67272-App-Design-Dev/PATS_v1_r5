class DosagesController < ApplicationController
  before_action :check_login
  
  def new
    @dosage = Dosage.new
    @visit  = Visit.find(params[:visit_id])
    @pet    = @visit.pet
  end
  
  def create
    @dosage = Dosage.new(dosage_params)
    if @dosage.save
      flash[:notice] = "Successfully added dosage."
      redirect_to visit_path(@dosage.visit)
    else
      @visit  = Visit.find(params[:dosage][:visit_id])
      @pet    = @visit.pet
      render action: 'new', locals: { visit: @visit, pet: @pet }
    end
  end
 
  def destroy
    @dosage = Dosage.find(params[:id])
    @dosage.destroy
    flash[:notice] = "Successfully removed this dosage."
    redirect_to visit_path(@dosage.visit)
  end

  private
    def dosage_params
      params.require(:dosage).permit(:visit_id, :medicine_id, :units_given, :discount)
    end

end