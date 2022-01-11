# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, :age, :gender, presence: true
  validates_associated :locations
  validates_associated :inventories

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { survivor: 0, admin: 1 }

  has_many :inventories, dependent: :destroy
  has_many :items, through: :inventories
  has_many :locations, dependent: :destroy
  has_many :trade_histories, dependent: :destroy

  has_many :reporters, class_name: 'Infection',
                       dependent: :destroy,
                       foreign_key: :reporter_id,
                       inverse_of: :reporter
  has_many :reports, class_name: 'Infection',
                     dependent: :destroy,
                     foreign_key: :reported_id,
                     inverse_of: :report

  has_many :base_traders, class_name: 'Trade',
                          dependent: :destroy,
                          foreign_key: :base_trader_id,
                          inverse_of: :base_trader
  has_many :traders, class_name: 'Trade',
                     dependent: :destroy,
                     foreign_key: :trader_id,
                     inverse_of: :trader

  has_one_attached :photo

  accepts_nested_attributes_for :inventories
  accepts_nested_attributes_for :locations

  scope :survivors_count, -> { where(role: 'survivor').count }
  scope :infected_survivors_count, -> { where(role: 'survivor').where(infected: true).count }
  scope :non_infected_survivors_count, -> { where(role: 'survivor').where(infected: false).count }
  scope :role_survivor, -> { where(role: 'survivor') }
  scope :role_admin, -> { where(role: 'admin') }
  scope :except_survivor, ->(current_user) { where.not(id: current_user.id) }
end
