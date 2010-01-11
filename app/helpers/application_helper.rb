# This is the helper module for the entire application.  It should only contain
# methods that are used thoughout the system.
module ApplicationHelper

	# Show the FLASH div if there is data in the flash object.
	def show_flash
		result = ''
		flash.each {|type, message| result << content_tag(:div, message, :id => 'notice', :class => type.to_s) } 
		return result
	end

  # Toggle the value of a checkbox between T and F using AJAX
  def toggle_value(object)
    remote_function(:url      => url_for(object),
                    :method   => :put,
                    :before   => "Element.show('spinner-#{object.id}')",
                    :complete => "Element.hide('spinner-#{object.id}')",
                    :with     => "this.name + '=' + this.checked")
  end
end
