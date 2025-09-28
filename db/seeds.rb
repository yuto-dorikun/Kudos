# テストユーザー作成
puts "Creating test users..."

# 組織データ
company1 = Organization.create!(name: "株式会社テスト1")
company2 = Organization.create!(name: "株式会社テスト2")

# 管理者ユーザー
admin = User.find_or_create_by(email: "admin@kudos.local") do |user|
  user.password = "password"
  user.password_confirmation = "password"
  user.first_name = "管理"
  user.last_name = "太郎"
  user.organization = company1
end

# 一般ユーザー1
user1 = User.find_or_create_by(email: "user1@kudos.local") do |user|
  user.password = "password"
  user.password_confirmation = "password"
  user.first_name = "田中"
  user.last_name = "次郎"
  user.organization = company1
end

# 一般ユーザー2
user2 = User.find_or_create_by(email: "user2@kudos.local") do |user|
  user.password = "password"
  user.password_confirmation = "password"
  user.first_name = "佐藤"
  user.last_name = "花子"
  user.organization = company2
end

puts "Successfully Created #{User.count} users"
puts ""
puts "=== Test Accounts ==="
puts "管理者: admin@kudos.local / password"
puts "ユーザー1: user1@kudos.local / password"
puts "ユーザー2: user2@kudos.local / password"
puts "===================="