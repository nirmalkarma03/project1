ActiveAdmin.register User do
    permit_params :name, :email, :status, :gender
  
    index do
    #   selectable_column
    #   id_column
      column :email
      column :name
      column :status
      column :gender
      actions
    end
  
    filter :email
    filter :created_at
  
    form do |f|
      f.inputs do
        f.input :name
        f.input :email
        f.input :status
        f.input :gender
      end
      f.actions
    end
  
  end
  