Factory.sequence :email do |n|
  "person#{n}@test.com"
end

Factory.define :user do |f|
  f.email { Factory.next(:email) }
  f.password 'secret'
end
