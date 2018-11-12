class SafeRedirectManagersController < ApplicationController
  def new
    @safe_redirect_manager = SafeRedirectManager.new
  end

  def create
    @safe_redirect_manager = SafeRedirectManager.new(safe_redirect_manager_params)

    if @safe_redirect_manager.prepare
      flash[:success] = "Success!"
      render :new
    else
      flash[:error] = "What have you done, boy?"
      render :new
    end
  end

  private

  def safe_redirect_manager_params
    params.require(:safe_redirect_manager).permit(:content)
  end
end
