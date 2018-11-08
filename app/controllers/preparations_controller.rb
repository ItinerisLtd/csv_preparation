class PreparationsController < ApplicationController
  # GET /preparations/new
  def new
    @preparation = Preparation.new
  end

  # POST /preparations
  def create
    @preparation = Preparation.new(preparation_params)

    if @preparation.prepare
      flash[:success] = "Successfully sanitized!"
      render :new
    else
      flash[:error] = "What have you done, boy?"
      render :new
    end
  end

  private
    # Only allow a trusted parameter "white list" through.
    def preparation_params
      params.require(:preparation).permit(:content)
    end
end
