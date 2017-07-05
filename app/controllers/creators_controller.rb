class CreatorsController < ApplicationController
  before_action :set_creator, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json

  def index
    @creators = Creator.all
    respond_with @creators
  end

  def show
    respond_with @creator
  end

  def new
    @creator = Creator.new
    respond_with @creator
  end

  def edit
    respond_with @creator
  end

  def create
    @creator = Creator.new(creator_params)
    @creator.model_fields.build
    flash[:notice] = 'Model Created!' if @creator.save
    redirect_to root_path
  end

  def update
    flash[:notice] = 'Model Updated!' if @creator.update(creator_params)
    respond_with @creator
  end

  def destroy
    @creator.destroy
    respond_with @creator
  end

  private
    def set_creator
      @creator = Creator.find(params[:id])
    end

    def creator_params
      params.require(:creator).permit(:name, model_fields_attributes: [:id, :field_name, :field_type, :_destroy])
    end
end
