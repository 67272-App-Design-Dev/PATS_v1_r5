class TreatmentsController < ApplicationController
  before_action :check_login

  def new
    @treatment = Treatment.new
    @visit     = Visit.find(params[:visit_id])
    @pet       = @visit.pet
  end
  
  def create
    @treatment = Treatment.new(treatment_params)
    if @treatment.save
      flash[:notice] = "Successfully added treatment."
      redirect_to visit_path(@treatment.visit)
    else
      @visit     = Visit.find(params[:treatment][:visit_id])
      @pet       = @visit.pet
      render action: 'new', locals: { visit: @visit, pet: @pet }
    end
  end
 
  def destroy
    @treatment = Treatment.find(params[:id])
    @treatment.destroy
    flash[:notice] = "Successfully removed this treatment."
    redirect_to visit_path(@treatment.visit)
  end

  private
    def treatment_params
      params.require(:treatment).permit(:visit_id, :procedure_id, :successful, :discount)
    end

end