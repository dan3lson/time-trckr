ActiveAdmin.register Log do
	scope :today

	permit_params :user_id, :name, :started_at, :stopped_at

	index do
	  selectable_column
	  column :user
	  column :name
	  column :started_at
	  column :stopped_at
	  column :created_at
	  actions
	end
end
