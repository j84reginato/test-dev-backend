class JsonValidatorService
  def validate_json(json)
    schema = {
        'type' => 'object',
        'properties' => {
            'externalCode' => {'type' => 'string'},
            'storeId' => {'type' => 'integer'},
            'subTotal' => {'type' => 'string'},
            'deliveryFee' => {'type' => 'string'},
            'total' => {'type' => 'string'},
            'total_shipping' => {'type' => 'string'},
            'country' => {'type' => 'string'},
            'state' => {'type' => 'string'},
            'city' => {'type' => 'string'},
            'district' => {'type' => 'string'},
            'street' => {'type' => 'string'},
            'complement' => {'type' => 'string'},
            'latitude' => {'type' => 'float'},
            'longitude' => {'type' => 'float'},
            'dtOrderCreate' => {'type' => 'date-time'},
            'postalCode' => {'type' => 'string'},
            'number' => {'type' => 'string'},
            'customer' => {
                "type": 'object',
                "properties": {
                    'externalCode' => {'type' => 'integer'},
                    'name' => {'type' => 'string'},
                    'email' => {'type' => 'string'},
                    'contact' => {'type' => 'string'}
                }
            },
            'items' => {
                "type": 'array',
                "properties": {
                    'externalCode' => {'type' => 'integer'},
                    'name' => {'type' => 'string'},
                    'price' => {'type' => 'float'},
                    'quantity' => {'type' => 'float'},
                    'total' => {'type' => 'float'},
                    'subItems' => {'type' => 'array'}
                }
            },
            'payments' => {
                "type": 'array',
                "properties": {
                    'type' => {'type' => 'string'},
                    'value' => {'type' => 'float'}
                }
            }
        }
    }

    JSON::Validator.validate(schema, json, strict: true)
  end
end
