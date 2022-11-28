class VeganuaryItemsController < ApplicationController
  before_action :set_veganuary_item, only: %i[ show edit update destroy ]

  # GET /veganuary_items or /veganuary_items.json
  def index
    @veganuary_items = VeganuaryItem.all
  end

  # GET /veganuary_items/1 or /veganuary_items/1.json
  def show
    render layout: false
  end

  # GET /veganuary_items/new
  def new
    @veganuary_item = VeganuaryItem.new
  end

  # GET /veganuary_items/1/edit
  def edit
  end

  # POST /veganuary_items or /veganuary_items.json
  def create
    @veganuary_item = VeganuaryItem.new(veganuary_item_params)

    respond_to do |format|
      if @veganuary_item.save
        format.html { redirect_to veganuary_item_url(@veganuary_item), notice: "Veganuary item was successfully created." }
        format.json { render :show, status: :created, location: @veganuary_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @veganuary_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /veganuary_items/1 or /veganuary_items/1.json
  def update
    respond_to do |format|
      if @veganuary_item.update(veganuary_item_params)
        format.html { redirect_to veganuary_item_url(@veganuary_item), notice: "Veganuary item was successfully updated." }
        format.json { render :show, status: :ok, location: @veganuary_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @veganuary_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /veganuary_items/1 or /veganuary_items/1.json
  def destroy
    @veganuary_item.destroy

    respond_to do |format|
      format.html { redirect_to veganuary_items_url, notice: "Veganuary item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_veganuary_item
      @veganuary_item = VeganuaryItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def veganuary_item_params
      params.require(:veganuary_item).permit(:company_name, :company_description, :url, :offer, :addresses, :company_logo, :offer_images)
    end
end
