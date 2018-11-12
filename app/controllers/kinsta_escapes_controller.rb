class KinstaEscapesController < ApplicationController
  def new
    @kinsta_escape = KinstaEscape.new
  end

  def create
    @kinsta_escape = KinstaEscape.new(kinsta_escape_params)

    if @kinsta_escape.prepare
      flash[:success] = "Success!"
      render :new
    else
      flash[:error] = "What have you done, boy?"
      render :new
    end
  end

  private

  def kinsta_escape_params
    params.require(:kinsta_escape).permit(:content)
  end
end
