ActiveAdmin.register User do
  permit_params :name, :email, :age, :phone
end
