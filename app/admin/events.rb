ActiveAdmin.register Event do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :event_name, :description, :event_date, :event_time, :price, :admin_user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:event_name, :description, :event_date, :event_time, :price, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form do |f|
    f.inputs do
      f.input :event_name
      f.input :description
      f.input :event_date
      f.input :event_time
      f.input :price
      f.input :admin_user_id, :input_html => { :value => f.current_admin_user.id }, as: :hidden
    end
    f.actions
  end
  
end
