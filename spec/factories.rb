Factory.sequence :email do |n|
  "person#{n}@test.com"
end

Factory.define :user do |f|
  f.email { Factory.next(:email) }
  f.password 'secret'
  f.balance "0.0"
end

Factory.define :cashflow do |c|
  c.user { Factory(:user) }
  c.value 0.01
end
