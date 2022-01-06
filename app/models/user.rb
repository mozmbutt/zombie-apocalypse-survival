class User < ApplicationRecord
  validates_presence_of :name, :age, :gender
  validates_associated :locations
  validates_associated :inventories

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: %i[survivor admin]

  has_many :inventories, dependent: :destroy
  has_many :items, through: :inventories
  has_many :locations, dependent: :destroy
  has_many :trade_histories, dependent: :destroy

  has_many :reporters, class_name: 'Infection', dependent: :destroy, foreign_key: :reporter_id
  has_many :reports, class_name: 'Infection', dependent: :destroy, foreign_key: :reported_id

  has_many :base_traders, class_name: 'Trade', dependent: :destroy, foreign_key: :base_trader_id
  has_many :traders, class_name: 'Trade', dependent: :destroy, foreign_key: :trader_id

  has_one_attached :photo

  accepts_nested_attributes_for :inventories
  accepts_nested_attributes_for :locations

  scope :survivors_count, -> { where(:role => 'survivor').count}
  scope :infected_survivors_count, -> { where(:role => 'survivor').where(:infected => true).count }
  scope :non_infected_survivors_count, -> { where(:role => 'survivor').where(:infected => false).count }
end
