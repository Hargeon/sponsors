ActiveAdmin.register Member do
  actions :all, except: [:edit]

  permit_params :name

  index do
    selectable_column
    column :id
    column :name
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :name
      row :created_at
    end
  end

  filter :name
  filter :created_at
end
