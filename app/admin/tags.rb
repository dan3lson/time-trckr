ActiveAdmin.register Tag do
	index do
	  selectable_column
	  column :user
	  column :name
	  column :created_at
	  actions
	end
end
