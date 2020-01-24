ActiveAdmin.register Member do
  permit_params :name

  show do
    attributes_table do
      row :name
      row :created_at
      row :ideas
    end
  end

  filter :name
  filter :created_at
end
