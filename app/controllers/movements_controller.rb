class MovementsController < ApplicationController
  before_action :set_movement, only:  [:show, :edit, :update, :destroy]

  # GET /movements
  def index
    @title = t('view.movements.index_title')
    @movements = Movement.all.preload(:client, :user)
    @filters = {}

    if params[:client_id]
      @movements = @movements.where(client_id: params[:client_id])
      @filters[:client_id] = @movements.first&.client || Client.find(params[:client_id])
    end

    if params[:user_id]
      @movements = @movements.where(user_id: params[:user_id])
      @filters[:user_id] = @movements.first&.user || User.find(params[:user_id])
    end

    @movements = @movements.order(created_at: :desc).page(params[:page])
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
    @movement = current_user.movements.build(movement_params)

    respond_to do |format|
      if @movement.save
        format.json { render json: {}, status: :ok }
      else
        format.json { render json: {}, status: :error }
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
    params.require(:movement).permit(:client_id, :amount, :kind)
  end
end
