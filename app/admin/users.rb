ActiveAdmin.register User do
	index do
	  selectable_column
	  column :email
	  column :created_at
	  actions
	end
end
