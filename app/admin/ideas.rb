ActiveAdmin.register Idea do
  includes(:user, :industries, :districts, :require_helps)

  permit_params :name, :description, :plan, :active, :active_time

  actions :all, except: [:new]

  scope :all
  scope :active
  scope :inactive
  scope :active_period
  scope :notification_period

  index do
    selectable_column
    column :id
    column :user
    column :name
    column :industries
    column :districts
    column :require_helps

    column :members do |idea|
      local_members = idea.local_members.includes(:member)
      local_members.map do |local_member|
        name = local_member.member.name
        "#{name} #{local_member.amount}"
      end
    end

    column :description
    column :plan
    column :active
    column :created_at

    actions
  end

  show do |idea|
    attributes_table do
      row :id
      row :user
      row :name
      row :description
      row :plan

      row :industries do
        idea.industries.map do |industry|
          link_to(industry.name, admin_industry_path(industry))
        end
      end

      row :districts do
        idea.districts.map do |district|
          link_to(district.name, admin_district_path(district))
        end
      end

      row :require_helps do
        idea.require_helps.map do |help|
          link_to(help.name, admin_require_help_path(help))
        end
      end

      row :members do
        local_members = idea.local_members.includes(:member)
        local_members.map do |local_member|
          name = local_member.member.name
          "#{name} #{local_member.amount}"
        end
      end

      row t(:sympathy) do
        "#{idea.likes.count} likes, #{idea.dislikes.count} dislikes, " +
          "#{RatingService.average_rating(idea)} average rating, " +
          "#{RatingService.count_votes(idea)} votes"
      end

      row t(:reviewed) do
        idea.views.count
      end

      row t(:active_from) do
        idea.active_time
      end

      row :active

      row :created_at

      panel t('activerecord.models.interest') do
        table_for idea.interests.includes(:user) do
          column t(:name) do |interest|
            link_to(interest.user.email, admin_idea_path(interest.user))
          end

          column t(:message) do |interest|
            interest.message
          end
        end
      end
    end
  end

  filter :industries
  filter :districts
  filter :members
  filter :require_helps
  filter :name
  filter :description
  filter :plan

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs do
      f.input :name
      f.input :description
      f.input :plan
      f.input :active
      f.input :active_time
    end

    f.actions
  end
end
