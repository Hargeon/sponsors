ActiveAdmin.register District do
  actions :all, except: [:edit]

  permit_params :name

  show do
    attributes_table do
      row :name
      row :created_at
    end
  end

  filter :name
  filter :created_at
end
