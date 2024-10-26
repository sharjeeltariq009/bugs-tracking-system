ActiveAdmin.register User do
  # Permit parameters for user creation and updates
  permit_params :name, :email, :password, :password_confirmation, :user_type

  # Display columns in the users index page
  index do
    selectable_column
    id_column
    column :name
    column :email
    column :user_type
    column :created_at
    actions
  end

  # Filters for search functionality on the user index page
  filter :name
  filter :email
  filter :user_type, as: :select, collection: User.user_types.keys
  filter :created_at

  # Show page for user details
  show do
    attributes_table do
      row :id
      row :name
      row :email
      row :user_type
      row :created_at
      row :updated_at
    end

    panel "Projects" do
      table_for user.projects do
        column :name
        column :description
        column :created_at
      end
    end
  end

  # User form for create and edit actions
  form do |f|
    f.inputs "User Details" do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :user_type, as: :select, collection: User.user_types.keys
    end
    f.actions
  end
end
