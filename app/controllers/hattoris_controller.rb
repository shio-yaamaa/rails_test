class HattorisController < ApplicationController
  
  def index
    @hattoris = Hattori.all
  end
  
  def show
    @hattori = Hattori.find(params[:id])
  end
  
end
