class ScreamingFrogsController < ApplicationController
  # GET /screaming_frogs/new
  def new
    @screaming_frog = ScreamingFrog.new
  end

  # POST /screaming_frogs
  def create
    @screaming_frog = ScreamingFrog.new(screaming_frog_params)

    if @screaming_frog.prepare
      flash[:success] = "Success!"
      render :new
    else
      flash[:error] = "What have you done, boy?"
      render :new
    end
  end

  private
    # Only allow a trusted parameter "white list" through.
    def screaming_frog_params
      params.require(:screaming_frog).permit(:content)
    end
end
