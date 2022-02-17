# frozen_string_literal: true

class ChartsController < ApplicationController
  before_action :authenticate_user!

  def index
    @charts = current_user.charts
  end

  def new
    @chart = charts.new
  end

  def create
    @chart = charts.build(chart_params)
    @chart.save ? redirect_to(charts_path) : render(:new)
  end

  private

  def charts
    current_user.charts
  end

  def chart_params
    params.require(:chart).permit(:title, :description, :items)
  end
end
