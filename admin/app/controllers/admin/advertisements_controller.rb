require_dependency "admin/application_controller"

module Admin
  class AdvertisementsController < ApplicationController
    before_action :set_advertisement, only: [:show, :edit, :update, :destroy]

    # GET /advertisements
    def index
      @advertisements = Advertisement.all
    end

    # GET /advertisements/1
    def show
    end

    # GET /advertisements/new
    def new
      @advertisement = Advertisement.new
    end

    # GET /advertisements/1/edit
    def edit
    end

    # POST /advertisements
    def create
      @advertisement = Advertisement.new(advertisement_params)

      if @advertisement.save
        redirect_to @advertisement, notice: 'Advertisement was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /advertisements/1
    def update
      if @advertisement.update(advertisement_params)
        redirect_to @advertisement, notice: 'Advertisement was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /advertisements/1
    def destroy
      @advertisement.destroy
      redirect_to advertisements_url, notice: 'Advertisement was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_advertisement
        @advertisement = Advertisement.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def advertisement_params
        params[:advertisement]
      end
  end
end
