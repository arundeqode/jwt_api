class SessionsController < ApplicationController
	def signup
		user = User.new(user_params)
		if user.save
			render json: {message: 'Account created'}, status: :ok
		else
			render json: {error: user.errors}, status: :unprocessable_entity
		end
	end

	def login
		user = User.find_by(email: user_params[:email])
		if user && user.authenticate(user_params[:password])

			render json: {token: token(user.id)}, status: :ok
		else
			render json: {errors: ['invalid credentials']}, status: :unprocessable_entity
		end
	end

	private

	def user_params
		params.require(:user).permit(:email, :password)
	end
end
