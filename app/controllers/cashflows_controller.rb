class CashflowsController < ApplicationController
  def index
    @cashflows = current_user.cashflows.order("created_at DESC").to_json(:only => [:id, :value, :note])
    render :json => { :balance => current_user.balance, :cashflows => @cashflows }
  end

  def create
    @cashflow = current_user.cashflows.new(params[:cashflow])

    if @cashflow.save
      render :json => { :status => "ok", :id => @cashflow.id }
    else
      render :json => { :status => "error" }
    end
  end

end
