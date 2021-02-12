class ProceduresController < ApplicationController

  before_action :set_procedure, only: [:show, :edit, :update, :destroy]
  before_action :check_login

  def index
    # get all visits in reverse chronological order, 10 per page
    @procedures = Procedure.alphabetical.paginate(page: params[:page]).per_page(10)
  end
  
  def show
    # get the cost history for this procedure
    @prices = @procedure.procedure_costs.chronological #.to_a.reverse
  end
  
  def new
    @procedure = Procedure.new
  end
  
  def create
    @procedure = Procedure.new(procedure_params)
    if @procedure.save
      flash[:notice] = "Successfully added #{@procedure.name}."
      redirect_to @procedure
    else
      render action: 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @procedure.update_attributes(procedure_params)
      flash[:notice] = "Successfully updated #{@procedure.name}."
      redirect_to @procedure
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @procedure.destroy
    flash[:notice] = "Successfully removed #{@procedure.name}."
    redirect_to procedures_url
  end

    private
    def set_procedure
      @procedure = Procedure.find(params[:id])
    end

    def procedure_params
      params.require(:procedure).permit(:name, :description, :length_of_time, :active)
    end
end