class OwnersController < ApplicationController
  # A callback to set up an @owner object to work with 
  before_action :set_owner, only: [:show, :edit, :update, :destroy]
  before_action :check_login
  authorize_resource

  def index
    # finding all the active owners and paginating that list (will_paginate)
    @active_owners = Owner.active.alphabetical.paginate(page: params[:page]).per_page(15)
  end

  def show
  #  Show the owner's details using his id
    # @owner = Owner.find(params[:id])
     # get all the pets for this owner
    @current_pets = @owner.pets.alphabetical.active.to_a

     # render template[:show]
    # layout 'application'

  end

  def new
    @owner = Owner.new
    # render template[:new]
    # layout 'application'
  end

  def edit
    # get @owner
    # @owner = Owner.find(params[:id])
    # render template[:edit]
    # layout 'application'
  end

  def create
    @owner = Owner.new(owner_params)
    if @owner.save
      # if saved to database
      flash[:notice] = "Successfully created #{@owner.proper_name}."
      redirect_to owner_path(@owner) # go to show owner page
    else
      # return to the 'new' form
      render action: 'new'
    end
  end

  def update
     # @owner = Owner.find(params[:id])
    if @owner.update_attributes(owner_params)
      flash[:notice] = "Successfully updated #{@owner.proper_name}."
      redirect_to @owner
    else
      render action: 'edit'
    end
  end

  def destroy
   # @owner = Owner.find(params[:id])

    @owner.destroy
    flash[:notice] = "Successfully removed #{@owner.proper_name} from the PATS system."
    redirect_to owners_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_owner
      @owner = Owner.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def owner_params
      params.require(:owner).permit(:first_name, :last_name, :street, :city, :state, :zip, :phone, :email, :active)
    end

end
