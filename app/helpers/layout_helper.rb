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
      out << fields.hidden_field(:_destroy)
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
    
    
    
  #borrowed from Spree sourcecode  
  # Make an admin tab that coveres one or more resources supplied by symbols
  # Option hash may follow. Valid options are
  #   * :label to override link text, otherwise based on the first resource name (translated)
  #   * :route to override automatically determining the default route
  #   * :match_path as an alternative way to control when the tab is active, /products would match /admin/products, /admin/products/5/variants etc.
  def nav_link(*args)
    options = {:label => args.first.to_s}
    if args.last.is_a?(Hash)
      options = options.merge(args.pop)
    end
    options[:route] ||=  "#{args.first}"

    destination_url = send("#{options[:route]}_path")
    
    css_classes = []

    selected = if options[:match_path]
      request.request_uri.starts_with?("/#{options[:match_path]}")
    else
      args.include?(controller.controller_name.to_sym)
    end
    css_classes << 'active' if selected

    if options[:css_class]
      css_classes << options[:css_class]
    end
    
    ## if more than one form, it'll capitalize all words
    label_with_first_letters_capitalized = t(options[:label]).gsub(/\b\w/){$&.upcase}
    link = link_to(label_with_first_letters_capitalized, destination_url, {:class => css_classes})
    
    content_tag('li', link, :class => css_classes.join(' '))
  end
    
    
    
end