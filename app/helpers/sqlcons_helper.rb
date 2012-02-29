module SqlconsHelper

  def incsection
	if session[:tutsec] < session[:maxsec]
	   session[:tutsec] += 1 
	end
	@qstring =  "empty"
	@qresults = nil
  
  end

  def incch
	session[:tutch] += 1 if session[:tutch] < 2
	session[:tutsec] = 1
  end

  def resetlesson
	session[:tutsec] = 1
  end


end
