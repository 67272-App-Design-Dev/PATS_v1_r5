class ProcedureCostsController < ApplicationController
  before_action :check_login
  
  def new
    @procedure_cost = ProcedureCost.new
    @procedure = Procedure.find(params[:procedure_id])
  end
  
  def create
    @procedure_cost = ProcedureCost.new(procedure_cost_params)
    @procedure_cost.start_date = Date.current
    @procedure_cost.cost = @procedure_cost.cost*100 unless @procedure_cost.cost.nil?
    if @procedure_cost.save
      flash[:notice] = "Successfully updated procedure costs."
      redirect_to procedure_path(@procedure_cost.procedure)
    else
      @procedure = Procedure.find(params[:procedure_cost][:procedure_id])
      render action: 'new', locals: { procedure: @procedure }
    end
  end

  private
    def procedure_cost_params
      params.require(:procedure_cost).permit(:procedure_id, :cost)
    end

end