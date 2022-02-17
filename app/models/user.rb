# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :confirmable,
    :validatable, :lockable, :timeoutable,
    :trackable # , :omniauthable

  has_many :charts
end
