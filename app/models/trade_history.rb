class TradeHistory < ApplicationRecord
  belongs_to :trade
  belongs_to :item
  belongs_to :user
end
