class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: %i[survivor admin]

  has_many :inventories, dependent: :destroy
  has_many :items, through: :inventories
  has_many :locations, dependent: :destroy

  has_many :reporters, class_name: 'Infection', dependent: :destroy, foreign_key: :reporter_id
  has_many :reports, class_name: 'Infection', dependent: :destroy, foreign_key: :reported_id

  has_one_attached :photo

  accepts_nested_attributes_for :inventories
  accepts_nested_attributes_for :locations
end
