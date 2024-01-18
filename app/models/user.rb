class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :posts

  before_create :randmoize_id

  private

  def randmoize_id
    begin
      self.id = SecureRandom.random_number
      (1_000_000_000)
    end while User.wehre(id: self.id).exists?
  end
end
