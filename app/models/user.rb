class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :phones, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

    def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
  		user = User.where(:provider => auth.provider, :uid => auth.uid).first
	  	unless user
	    user = User.create(fname:auth.extra.raw_info.first_name,
	    					lname:auth.extra.raw_info.first_name,
	                         provider:auth.provider,
	                         uid:auth.uid,
	                         email:auth.info.email,
	                         password:Devise.friendly_token[0,20]
	                         )
	  	end
	  	user
	end


	def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
	    data = access_token.info
	    user = User.where(:email => data["email"]).first

	    unless user
	        user = User.create(fname: data["first_name"],
	        		lname: data["last_name"],
		        	google_oauth2: 1,
	      			gid: access_token["uid"],
	             	email: data["email"],
	             	image: data["image"],
		            password: Devise.friendly_token[0,20]
	            )
	    end
	    user
	end

	def self.authenticate_user(params)
		user = User.where(:email => params[:email]).first
		if user.persisted?
			provider = (user.google_oauth2 == 1) ? 'google_oauth2' : 'facebook'
			return {'found' => true, 'provider' => provider}
		else
			return {'found' => false}
		end

	end
	def self.create_user(params)
		user = User.create(fname:params[:fname],
				lname:params[:lname],
	             provider:params[:provider],
	             uid:params[:uid],
	             email:params[:email],
	             password:Devise.friendly_token[0,20]
	         )
		user.phones.create(
				number: params[:number],
				make: params[:make],
				model: params[:model],
				imei: params[:imei]
			)
		user
	end

	def self.update_user(params)
		user = User.find_by_email(params[:email])
		if params[:provider] == 'facebook'
			user.facebook = 1
			user.fid = params[:uid]
		elsif params[:provider] == 'google_oauth2'
			user.google_oauth2 = 1
			user.gid = params[:uid]
		end
		user.save
		user
	end
end
