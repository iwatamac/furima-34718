class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items

  with_options presence: true do
    validates :nickname, uniqueness: { case_sensitive: false }, length: { maximum: 40 }
    validates :password, format: { with: /(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{6,}/, message: 'Include both letters and numbers' }
    with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'is invalid. Input full_width characters.' } do
      validates :last_name
      validates :first_name
    end
    with_options format: { with: /\A[ァ-ヶー]+\z/, message: 'is invalid. Input full_width katakana characters.' } do
      validates :last_name_kana
      validates :first_name_kana
    end
    validates :birthday
  end
end
