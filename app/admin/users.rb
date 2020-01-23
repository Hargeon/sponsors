ActiveAdmin.register User do
  permit_params :name, :email, :age, :phone, :user_type

  index do
    selectable_column
    column :id
    column :name
    column :email
    column :age
    column :phone
    column :user_type
    column :created_at
    actions
  end

  show do |user|
    attributes_table do
      row :id
      row :name
      row :email
      row :age
      row :phone
      row :user_type
      row :created_at

      if user.sponsor?
        row :industries
        row :require_helps
        row :districts

        interests = user.interests.includes(:idea)

        row 'Interests' do
          interests.map do |interest|
            link_to interest.idea.name, admin_idea_path(interest.idea)
          end
        end

        row 'Messages' do
          interests.map do |interest|
            "#{interest.idea.name} - #{interest.message}"
          end
        end

        row 'Activity ' do
          "#{user.likes.count} likes, #{user.dislikes.count} dislikes, #{user.ratings.count} ratings"
        end

      elsif user.businessman?
        row :ideas
      end

      row 'Reviewed ideas' do
        user.views.count
      end
    end
  end

  filter :name
  filter :email
  filter :phone
  filter :age
  filter :user_type
  filter :created_at
end
