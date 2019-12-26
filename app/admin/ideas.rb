ActiveAdmin.register Idea do
  permit_params :name, :description, :plan, :user_id,
                local_industries_attributes: [:id, :industry_id, :_destroy],
                local_districts_attributes: [:id, :district_id, :_destroy],
                local_require_helps_attributes: [:id, :require_help_id, :_destroy],
                local_members_attributes: [:id, :amount, :member_id, :_destroy]

  index do
    selectable_column
    column :id
    column :user
    column :name
    column :description
    column :plan
    column :industries
    column :districts
    column :require_helps
    column :members do |idea|
      idea.local_members.map do |member|
        name = Member.find(member.member_id).name
        "#{name} #{member.amount}"
      end
    end
    actions
  end

  show do |idea|
    attributes_table do
      row :user
      row :name
      row :description
      row :plan

      row :industries do |idea|
        idea.industries.map { |industry| industry.name }
      end

      row :districts do |idea|
        idea.districts.map { |district| district.name }
      end

      row :require_helps do |idea|
        idea.require_helps.map { |help| help.name }
      end

      row :members do |idea|
        idea.local_members.map do |member|
          name = Member.find(member.member_id).name
          "#{name} #{member.amount}"
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
