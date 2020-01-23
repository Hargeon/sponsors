ActiveAdmin.register Idea do
  permit_params :name, :description, :plan, :user_id,
                local_industries_attributes: [:id, :industry_id, :_destroy],
                local_districts_attributes: [:id, :district_id, :_destroy],
                local_require_helps_attributes: [:id, :require_help_id, :_destroy],
                local_members_attributes: [:id, :amount, :member_id, :_destroy]

  controller do
    def scoped_collection
      super.includes :user, :industries, :districts, :require_helps
    end
  end

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
        idea.industries.map(&:name)
      end

      row :districts do
        idea.districts.map(&:name)
      end

      row :require_helps do
        idea.require_helps.map(&:name)
      end

      row :members do
        local_members = idea.local_members.includes(:member)
        local_members.map do |local_member|
          name = local_member.member.name
          "#{name} #{local_member.amount}"
        end
      end

      row 'Sympathy' do
        "#{idea.likes.count} likes, #{idea.dislikes.count} dislikes, " +
          "#{RatingService.average_rating(idea)} average rating, " +
          "#{RatingService.count_votes(idea)} votes"
      end

      row 'Views' do
        idea.views.count
      end

      interests = idea.interests.includes(:user)

      row 'Interests' do
        interests.map do |interest|
          link_to interest.user.email, admin_user_path(interest.user)
        end
      end

      row 'Messages' do
        interests.map do |interest|
          "#{interest.user.email} - #{interest.message}"
        end
      end

      row 'Active from' do
        idea.active_time
      end

      row :active

      row :created_at
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
      f.input :user
      f.input :name
      f.input :description
      f.input :plan
    end

    f.inputs do
      f.has_many :local_industries, allow_destroy: true do |n_f|
        n_f.input :industry
      end
    end

    f.inputs do
      f.has_many :local_districts, allow_destroy: true do |n_f|
        n_f.input :district
      end
    end

    f.inputs do
      f.has_many :local_require_helps, allow_destroy: true do |n_f|
        n_f.input :require_help
      end
    end
    f.inputs do
      f.has_many :local_members, allow_destroy: true do |a|
        a.input :amount
        a.input :member
      end
    end
    f.actions
  end
end
