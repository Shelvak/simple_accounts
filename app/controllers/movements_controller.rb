class MovementsController < ApplicationController
  before_action :set_movement, only:  [:show, :edit, :update, :destroy]

  # GET /movements
  def index
    @title = t('view.movements.index_title')
    @movements = Movement.all.page(params[:page])
  end

  # GET /movements/1
  def show
    @title = t('view.movements.show_title')
  end

  # GET /movements/new
  def new
    @title = t('view.movements.new_title')
    @movement = Movement.new
  end

  # GET /movements/1/edit
  def edit
    @title = t('view.movements.edit_title')
  end

  # POST /movements
  def create
    @title = t('view.movements.new_title')
    @movement = Movement.new(movement_params)

    respond_to do |format|
      if @movement.save
        format.html { redirect_to @movement, notice: t('view.movements.correctly_created') }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PUT /movements/1
  def update
    @title = t('view.movements.edit_title')

    respond_to do |format|
      if @movement.update(movement_params)
        format.html { redirect_to @movement, notice: t('view.movements.correctly_updated') }
      else
        format.html { render action: 'edit' }
      end
    end
  rescue ActiveRecord::StaleObjectError
    redirect_to edit_movement_url(@movement), alert: t('view.movements.stale_object_error')
  end

  # DELETE /movements/1
  def destroy
    @movement.destroy

    redirect_to movements_url, notice: t('view.movements.correctly_destroyed')
  end

  private

  def set_movement
    @movement = Movement.find(params[:id])
  end

  def movement_params
    params.require(:movement).permit(:client, :amount, :kind, :user)
  end
end
