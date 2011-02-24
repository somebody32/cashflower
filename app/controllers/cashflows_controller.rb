class CashflowsController < ApplicationController
  def index
    render :json => { :balance => current_user.balance, :cashflows => current_user.cashflows.to_json }
  end

  def create
    cashflow = current_user.cashflows.new(params[:cashflow])

    if cashflow.save
      render :json => { :status => "ok" }
    else
      render :json => { :status => "error" }
    end
  end

end
