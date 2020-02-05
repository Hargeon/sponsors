ActiveAdmin.register Rating do
  includes(:user, :idea)

  actions :show, :index

  index do
    selectable_column
    column :id
    column :attraction
    column :strategy
    column :competitiveness
    column :finance
    column :idea
    column :user
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :attraction
      row :strategy
      row :competitiveness
      row :finance
      row :idea
      row :user
      row :created_at
    end
  end

  filter :attraction
  filter :strategy
  filter :competitiveness
  filter :finance
  filter :created_at
end
