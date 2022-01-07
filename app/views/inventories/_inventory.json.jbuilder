json.extract! inventory, :id, :user, :item, :stock, :created_at, :updated_at
json.url inventory_url(inventory, format: :json)
