module NavigationHelpers
  def path_to(page_name)
    case page_name
 
    when /the home\s?page/
      '/'
    when /the About Us\s?page/
      about_path
    when /the Contact Us\s?page/
      contact_path
    when /the Privacy\s?page/
      privacy_path
    when /the owners\s?page/
      owners_path      
    when /the new owner\s?page/
      new_owner_path
    when /the details on Mark Heimann/
      owner_path(@mark)
    when /the edit Alex\s?page/
      edit_owner_path(@alex)  

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)