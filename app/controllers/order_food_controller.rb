class OrderFoodController < ApplicationController
  protect_from_forgery with: :exception

  def index

  end

  def show
    @order_food = OrderFood.find(params[:id])
  end

  def new

  end

  def create
    #render plain: params[:order_food].inspect
    @order_food = OrderFood.new(food_order_params)
    response = send_food_order_to_dc_api(@order_food)
    if response
      @order_food.save
      redirect_to @order_food
    end
  rescue StandardError => e
    render plain: {
        error: e
    }, status: :unprocessable_entity
  end

  private def food_order_params
    params.require(:order_food).permit(:body)
  end

  private def send_food_order_to_dc_api(order_food)
    request_sender_service = RequestSenderService.new
    json_parser_service = JsonParserService.new
    request_sender_service.post(json_parser_service.parse_json(order_food))
  end
end
