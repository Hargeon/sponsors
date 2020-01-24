ActiveAdmin.register Rating do
  permit_params :user_id, :idea_id, :attraction,
                :strategy, :competitiveness, :finance

  controller do
    def scoped_collection
      super.includes :user, :idea
    end
  end
end
