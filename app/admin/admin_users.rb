ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation, :locale

  actions :all, except: [:edit]

  index do
    selectable_column
    id_column
    column :email
    column :created_at
    column :locale
    actions
  end

  show do
    attributes_table do
      row :id
      row :email
      row :created_at
      row :locale
    end
  end

  filter :email
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :locale
    end
    f.actions
  end
end
