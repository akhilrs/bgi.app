module ApplicationHelper
	def title
		base_title = 'BGI RoR App'
		if @title.nil?
			base_title
		else
			"#{base_title} | #{@title}"
		end
	end

	def logo
		image_tag("logo.png", :alt => "BGI RoR App", :class => "round")
	end
end
