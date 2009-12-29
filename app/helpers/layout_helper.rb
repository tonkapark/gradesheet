module LayoutHelper

  def title(page_title, show_title = true)
    @content_for_title = page_title.to_s
    @show_title = show_title
  end
  
  def show_title?
    @show_title
  end
  
  def stylesheet(*args)
    content_for(:head) { stylesheet_link_tag(*args) }
  end
  
  def javascript(*args)
    content_for(:head) { javascript_include_tag(*args) }
  end
  
  def remove_link_unless_new_record(fields)
    unless fields.object.new_record?
      out = ''
      out << fields.hidden_field(:_delete)
      out << link_to_function("delete", "$(this).up('.#{fields.object.class.name.underscore}').hide(); $(this).previous().value = '1'")
      out
    end
  end
  
  def add_record_link(form_builder, method, caption, options = {})
      options[:object] ||= form_builder.object.class.reflect_on_association(method).klass.new
      options[:partial] ||= method.to_s.singularize
      options[:form_builder_local] ||= :f
      options[:insert] ||= method
      
      link_to_function(caption) do |page|
        form_builder.fields_for(method, options[:object], :child_index => 'NEW_RECORD') do |f|
          html = render(:partial => options[:partial], :locals => { options[:form_builder_local] => f })
          page << %{
            $('#{options[:insert]}').insert({
              bottom: '#{escape_javascript(html)}'.replace(/NEW_RECORD/g, new Date().getTime())
            });
          }
        end
      end
    end
end