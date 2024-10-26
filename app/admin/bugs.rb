ActiveAdmin.register Bug do
  permit_params :title, :description, :deadline, :category, :status, :project_id, :developer_id

  # Customize index page
  index do
    selectable_column
    id_column
    column :title
    column :status
    column :project
    column :developer
    actions
  end

  # Filters
  filter :title
  filter :status, as: :select, collection: ['not_started', 'started','resolved', 'completed']
  filter :project
  filter :developer
  filter :created_at

  # Form for creating/editing bugs
  form do |f|
    f.inputs "Bug Details" do
      f.input :title
      f.input :description
      f.input :deadline, as: :datepicker
      f.input :project
      f.input :developer, as: :select, collection: User.where(user_type: 'developer')
      f.input :status, as: :select, collection: ['not_started', 'started','resolved', 'completed']
      f.input :category, as: :select, collection: ['feature', 'bug']
    end
    f.actions
  end

  # Show page customization
  show do
    attributes_table do
      row :title
      row :description
      row :deadline
      row :category
      row :status
      row :project
      row :developer
      row :created_at
      row :updated_at
    end
  end
end

