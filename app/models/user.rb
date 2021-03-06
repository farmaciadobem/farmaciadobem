class User < ActiveRecord::Base
  enum role: [:normal_user, :admin]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :perfil
  has_many :depoimentos
  has_many :enderecos
  has_many :doacaos
  has_many :carrinhos

end
