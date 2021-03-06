ActiveAdmin.register SidesGroup do
	permit_params :name,:menu_item_id,:group_side,:side_type,:multi_select,sides_items_attributes: [:id,:name,:price,:menu_item_id, :_destroy ]

	form do |f|
		f.semantic_errors *f.object.errors.keys
		f.inputs "SidesGroup" do 
			f.input :name
			f.input :side_type, :prompt => 'Select Sides Type', :as => :select, :collection => ["Extra","Choice"]
			f.input :group_side
			f.input :multi_select
			f.input :menu_item_id, :prompt => 'Select Menu Item', :as => :select, :collection => MenuItem.all.map{|m| [m.name, m.id]}
		end
		f.has_many :sides_items,heading: 'Items of Sides Group' do |item|
      item.input :name
      item.input :price
      item.input :_destroy, :as => :boolean
    end
		f.actions
	end


	show do
  	@sides_group = SidesGroup.find(params["id"])
    attributes_table do
      row :name
      row "Menu Item" do |n|
      	n.menu_items.each do |item|
		      link_to(item.name, admin_menu_item_path(item.id))
		    end
	    end
    end
    panel "Sides Items" do
    	render(:partial => "sides_item_detail", :locals => {:sides_group => @sides_group,:context => self})
    end
  end


end
