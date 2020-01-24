ActiveAdmin.register Rating do
  includes(:user, :idea)

  actions :show, :index

  filter :attraction
  filter :strategy
  filter :competitiveness
  filter :finance
  filter :created_at
end
