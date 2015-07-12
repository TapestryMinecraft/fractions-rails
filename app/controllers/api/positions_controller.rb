class Api::PositionsController < ApplicationController
  before_action :must_be_signed_in, except: [:show, :index]
  before_action :find_or_initialize_position, except: [:create, :index]

  def create
    @fraction = Fraction.find(position_params[:fraction_id])
    @position = @fraction.positions.new(position_params);

    # TODO complex position initialization
    # needs authorizations
    if @position.save
      render :show
    else
      render @position.errors.full_messages, status: 422
    end
  end

  def show
  end

  private

    def position_params
      params.require(:position).permit(:name, :fraction_id)
    end

    def find_or_initialize_position
      @position = params[:id] ? Position.find(params[:id]) : Position.new
    end
end