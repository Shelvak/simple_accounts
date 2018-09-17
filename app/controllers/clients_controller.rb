class ClientsController < ApplicationController
  before_action :set_client, only:  [:show, :edit, :update, :destroy]

  # GET /clients
  def index
    @title = t('view.clients.index_title')
    @clients = Client.all.page(params[:page])
  end

  # GET /clients/1
  def show
    @title = t('view.clients.show_title')
  end

  # GET /clients/new
  def new
    @title = t('view.clients.new_title')
    @client = Client.new
  end

  # GET /clients/1/edit
  def edit
    @title = t('view.clients.edit_title')
  end

  # POST /clients
  def create
    @title = t('view.clients.new_title')
    @client = Client.new(client_params)

    respond_to do |format|
      if @client.save
        format.html { redirect_to @client, notice: t('view.clients.correctly_created') }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PUT /clients/1
  def update
    @title = t('view.clients.edit_title')

    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to @client, notice: t('view.clients.correctly_updated') }
      else
        format.html { render action: 'edit' }
      end
    end
  rescue ActiveRecord::StaleObjectError
    redirect_to edit_client_url(@client), alert: t('view.clients.stale_object_error')
  end

  # DELETE /clients/1
  def destroy
    @client.destroy

    redirect_to clients_url, notice: t('view.clients.correctly_destroyed')
  end

  private

  def set_client
    @client = Client.find(params[:id])
  end

  def client_params
    params.require(:client).permit(:name, :identifier, :card)
  end
end
