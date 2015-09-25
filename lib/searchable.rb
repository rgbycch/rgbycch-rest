##
# A module which can be used by model classes to provide simple search functionality

module Searchable

  ##
  # Searches for items by sending `find` or `all` methods to the current class.

  def search(params = {})
    items = params[self.id_params_identifier].present? ? self.send('find', params[self.id_params_identifier]) : self.send('all')
    items = items.filter_by_title(params[:keyword]) if params[:keyword]
    items
  end

  ##
  # Should be implemented by classes extending `Searchable`

  def id_params_identifier
    raise NotImplementedError, "Classes including the Searchable module should implement this class method"
  end

end