module SqlconsHelper

  def incsection
	session[:tutsec] += 1
	@qstring =  "empty"
	@qresults = nil
  end

  def resetlesson
	session[:tutsec] = 1
  end


end
