class JsonParserService
  def parse_json(food_order)
    json_data = JSON.parse(food_order.body)

    parsed_api_data = {
        externalCode: json_data['id'].to_s,
        storeId: json_data['store_id'],
        subTotal: json_data['total_amount'].to_s,
        deliveryFee: json_data['total_shipping'].to_s,
        total: json_data['total_amount_with_shipping'].to_s,
        country: json_data['shipping']['receiver_address']['country']['id'],
        state: 'SP',
        city: json_data['shipping']['receiver_address']['city']['name'],
        district: json_data['shipping']['receiver_address']['neighborhood']['name'],
        street: json_data['shipping']['receiver_address']['street_name'],
        complement: 'galpao',
        latitude: json_data['shipping']['receiver_address']['latitude'],
        longitude: json_data['shipping']['receiver_address']['longitude'],
        dtOrderCreate: json_data['shipping']['receiver_address']['date_created'],
        postalCode: json_data['shipping']['receiver_address']['zip_code'],
        number: json_data['shipping']['receiver_address']['street_number'],
        customer: {
            externalCode: json_data['buyer']['id'],
            name: json_data['buyer']['nickname'],
            email: json_data['buyer']['email'],
            contact: "#{json_data['buyer']['phone']['area_code']}#{json_data['buyer']['phone']['number']}"
        },
        items: get_items(json_data['order_items']),
        payments: get_payments(json_data['payments']),
        total_shipping: json_data['total_shipping'].to_s
    }

    json_validator_service = JsonValidatorService.new
    raise 'Invalid Json. Please check the submitted data!' unless json_validator_service.validate_json(parsed_api_data.to_json)

    parsed_api_data
  end

  private

  def get_items(order_items)
    items = []

    order_items.each do |order_item|
      item = {
          externalCode: order_item['item']['id'],
          name: order_item['item']['title'],
          price: order_item['unit_price'],
          quantity: order_item['quantity'],
          total: order_item['unit_price'],
          subItems: []
      }

      items << item
    end

    items
  end

  def get_payments(payments)
    payments_json = []

    payments.each do |payment|
      payment_json = {
          type: payment['payment_type'].upcase,
          value: payment['total_paid_amount']
      }
      payments_json << payment_json
    end

    payments_json
  end

end
