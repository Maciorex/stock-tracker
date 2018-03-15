class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships

  def stock_already_added?(ticker_symbol)
    stock = Stock.find_by_ticker(ticker_symbol)
    return false unless stock
    user_stocks.where(stock_id: stock.id).exists?
  end

  def under_stock_limit?
    (user_stocks.count < 25)
  end

  def can_add_stock?(ticker_symbol)
    under_stock_limit? && !stock_already_added?(ticker_symbol)
  end

  def full_name
    return "#{first_name} #{second_name}" if (first_name || second_name)
    "Anonymous"
  end

  def self.search(param)
    param.strip.downcase!
    to_return = (first_name_matches(param) + second_name_matches(param) + email_matches(param)).uniq
    return nil unless to_return
    to_return
  end

  def self.first_name_matches(param)
    matches('first_name', param)
  end

  def self.second_name_matches(param)
    matches('second_name', param)
  end

  def self.email_matches(param)
    matches('email', param)
  end

  def self.matches(field, param)
    User.where("#{field} like ?", "%#{param}%")
  end

  def except_current_user(users)
    users.reject { |user| user.id == self.id }
  end

  def not_friends_with?(friend_id)
    friendships.where(friend_id: friend_id).count < 1
  end
end
