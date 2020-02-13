ActiveAdmin.register User do
  actions :index, :show, :destroy

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

      row t(:reviewed) do
        user.views.count
      end

      if user.sponsor?
        row :industries
        row :require_helps
        row :districts

        row t(:sympathy) do
          "#{user.likes.count} #{t(:likes)}, #{user.dislikes.count} #{t(:dislikes)}, #{user.ratings.count} #{t(:ratings)}"
        end

        panel t('activerecord.models.interest') do
          table_for user.interests.includes(:idea) do
            column t('activerecord.models.idea') do |interest|
              link_to(interest.idea.name, admin_idea_path(interest.idea))
            end

            column t(:message) do |interest|
              interest.message
            end
          end
        end

      elsif user.businessman?
        panel t('activerecord.models.idea') do
          table_for user.ideas.includes(:interests) do
            column t(:title) do |idea|
              link_to(idea.name, admin_idea_path(idea))
            end

            column t(:message) do |idea|
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
end
