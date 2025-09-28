# テストユーザーと組織階層作成
puts "Creating test organizations and hierarchy..."

# 組織データ
company1 = Organization.find_or_create_by!(name: "株式会社テスト1")
company2 = Organization.find_or_create_by!(name: "株式会社テスト2")

# === 組織1の階層構造 ===
puts "Creating hierarchy for #{company1.name}..."

# 支社作成
tokyo_office = Office.find_or_create_by!(
  organization: company1,
  name: "東京本社",
  is_headquarters: true,
  address: "東京都千代田区"
)

osaka_office = Office.find_or_create_by!(
  organization: company1,
  name: "大阪支社",
  is_headquarters: false,
  address: "大阪府大阪市"
)

# 部署作成（東京本社）
sales_dept = Department.find_or_create_by!(
  organization: company1,
  office: tokyo_office,
  name: "営業部"
)

dev_dept = Department.find_or_create_by!(
  organization: company1,
  office: tokyo_office,
  name: "開発部"
)

hr_dept = Department.find_or_create_by!(
  organization: company1,
  office: tokyo_office,
  name: "人事部"
)

# 部署作成（大阪支社）
sales_osaka_dept = Department.find_or_create_by!(
  organization: company1,
  office: osaka_office,
  name: "営業部"
)

# 課作成（営業部）
first_sales_section = Section.find_or_create_by!(
  organization: company1,
  department: sales_dept,
  name: "第一営業課"
)

second_sales_section = Section.find_or_create_by!(
  organization: company1,
  department: sales_dept,
  name: "第二営業課"
)

# 課作成（開発部）
frontend_section = Section.find_or_create_by!(
  organization: company1,
  department: dev_dept,
  name: "フロントエンド課"
)

backend_section = Section.find_or_create_by!(
  organization: company1,
  department: dev_dept,
  name: "バックエンド課"
)

# === 組織2の階層構造（シンプル） ===
puts "Creating hierarchy for #{company2.name}..."

# 本社のみ
main_office = Office.find_or_create_by!(
  organization: company2,
  name: "本社",
  is_headquarters: true,
  address: "神奈川県横浜市"
)

# 部署1つ
general_dept = Department.find_or_create_by!(
  organization: company2,
  office: main_office,
  name: "総務部"
)

# === ユーザー作成 ===
puts "Creating test users..."

# 管理者ユーザー（組織1）
admin = User.find_or_create_by(email: "admin@kudos.local") do |user|
  user.password = "password"
  user.password_confirmation = "password"
  user.first_name = "管理"
  user.last_name = "太郎"
  user.organization = company1
  user.office = tokyo_office
  user.department = hr_dept
end

# 営業部長（組織1）
sales_manager = User.find_or_create_by(email: "sales-manager@kudos.local") do |user|
  user.password = "password"
  user.password_confirmation = "password"
  user.first_name = "営業"
  user.last_name = "部長"
  user.organization = company1
  user.office = tokyo_office
  user.department = sales_dept
end

# 営業課長（組織1）
sales_section_manager = User.find_or_create_by(email: "sales-section@kudos.local") do |user|
  user.password = "password"
  user.password_confirmation = "password"
  user.first_name = "第一"
  user.last_name = "課長"
  user.organization = company1
  user.office = tokyo_office
  user.department = sales_dept
  user.section = first_sales_section
end

# 開発者（組織1）
developer = User.find_or_create_by(email: "dev@kudos.local") do |user|
  user.password = "password"
  user.password_confirmation = "password"
  user.first_name = "開発"
  user.last_name = "太郎"
  user.organization = company1
  user.office = tokyo_office
  user.department = dev_dept
  user.section = frontend_section
end

# 一般ユーザー1（組織1）
user1 = User.find_or_create_by(email: "user1@kudos.local") do |user|
  user.password = "password"
  user.password_confirmation = "password"
  user.first_name = "田中"
  user.last_name = "次郎"
  user.organization = company1
  user.office = tokyo_office
  user.department = sales_dept
  user.section = second_sales_section
end

# 一般ユーザー2（組織2）
user2 = User.find_or_create_by(email: "user2@kudos.local") do |user|
  user.password = "password"
  user.password_confirmation = "password"
  user.first_name = "佐藤"
  user.last_name = "花子"
  user.organization = company2
  user.office = main_office
  user.department = general_dept
end

# === 管理職の設定 ===
sales_dept.update!(manager: sales_manager)
first_sales_section.update!(manager: sales_section_manager)

puts ""
puts "=== 作成完了 ==="
puts "組織: #{Organization.count}社"
puts "支社: #{Office.count}拠点"
puts "部署: #{Department.count}部署"
puts "課: #{Section.count}課"
puts "ユーザー: #{User.count}名"
puts ""
puts "=== Test Accounts ==="
puts "管理者: admin@kudos.local / password"
puts "営業部長: sales-manager@kudos.local / password"
puts "営業課長: sales-section@kudos.local / password"
puts "開発者: dev@kudos.local / password"
puts "ユーザー1: user1@kudos.local / password"
puts "ユーザー2: user2@kudos.local / password"
puts "===================="