class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  followability

  has_many :posts
  has_many :comments
  has_many :likes

  has_one_attached :avatar

  before_create :randmoize_id

  # def self.ransackable_attributes(auth_object = nil)
  #   ["bio", "created_at", "email", "id", "updated_at", "username"]
  #   # Add other attributes that you want to allow for searching
  # end

  def self.ransackable_attributes(auth_object = nil)
    %w[id email username created_at updated_at]
  end

  def unfollow(user)
    followerable_relationships.where(followable_id: user.id).destroy_all
  end

  private

  def randmoize_id
    begin
      self.id = SecureRandom.random_number(1_000_000_000)
    end while User.where(id: self.id).exists?
  end
end
