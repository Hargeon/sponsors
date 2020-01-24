ActiveAdmin.register User do
  permit_params :name, :email, :age, :phone, :user_type,
                sponsor_industries_attributes: [:id, :industry_id, :_destroy],
                sponsor_districts_attributes: [:id, :district_id, :_destroy],
                sponsor_helps_attributes: [:id, :require_help_id, :_destroy]

  scope :all
  scope :sponsors
  scope :businessmen

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

      row 'Reviewed ideas' do
        user.views.count
      end

      if user.sponsor?
        row :industries
        row :require_helps
        row :districts

        row 'Activity' do
          "#{user.likes.count} likes, #{user.dislikes.count} dislikes, #{user.ratings.count} ratings"
        end

        panel 'Interests' do
          table_for user.interests.includes(:idea) do
            column 'Ideas' do |interest|
              link_to interest.idea.name, admin_idea_path(interest.idea)
            end

            column 'Messages' do |interest|
              interest.message
            end
          end
        end

      elsif user.businessman?
        panel 'Ideas' do
          table_for user.ideas.includes(:interests) do
            column 'Names' do |idea|
              link_to idea.name, admin_idea_path(idea)
            end

            column 'Messages' do |idea|
              idea.interests.map(&:message)
            end
          end
        end
      end
    end
  end

  filter :name
  filter :email
  filter :phone
  filter :age
  filter :user_type
  filter :created_at

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs do
      f.input :name
      f.input :email
      f.input :phone
      f.input :age
      f.input :user_type
    end

    f.inputs do
      f.has_many :sponsor_industries, allow_destroy: true do |n_f|
        n_f.input :industry
      end
    end

    f.inputs do
      f.has_many :sponsor_districts, allow_destroy: true do |n_f|
        n_f.input :district
      end
    end

    f.inputs do
      f.has_many :sponsor_helps, allow_destroy: true do |n_f|
        n_f.input :require_help
      end
    end

    f.actions
  end
end
