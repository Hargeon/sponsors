ActiveAdmin.register Industry do
  permit_params :name

  show do
    attributes_table do
      row :name
      row :created_at
      row :ideas
      row :users
    end
  end

  filter :name
  filter :created_at
end
