
  ActiveAdmin.register Project do
  permit_params :name, :description, user_ids: [], developer_ids: [], qa_ids: []

  # Customize index page
  index do
    selectable_column
    id_column
    column :name
    column :description
    column :created_at
    actions
  end

  # Filters
  filter :name
  filter :description
  filter :created_at

  # Form for creating/editing projects
  form do |f|
    f.inputs "Project Details" do
      f.input :name
      f.input :description
      f.input :users, as: :check_boxes, collection: User.where(user_type: 'manager') # Assign Managers
      f.input :developers, as: :check_boxes, collection: User.where(user_type: 'developer')
      f.input :qas, as: :check_boxes, collection: User.where(user_type: 'qa')
    end
    f.actions
  end

  # Show page customization
  show do
    attributes_table do
      row :name
      row :description
      row :created_at
      row :updated_at
      row :developers do |project|
        project.developers.map(&:name).join(", ")
      end
      row :qas do |project|
        project.qas.map(&:name).join(", ")
      end
    end
  end
end


