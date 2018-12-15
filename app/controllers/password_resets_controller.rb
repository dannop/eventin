class PasswordResetsController < ApplicationController
    def new
    end

    def create
        user = User.find_by(email: params[:email])
        if user
            user.generate_password_reset_token!
            UserMailer.password_reset(user).deliver
            redirect_to login_path
        else
            flash[:error] = "Desculpe, esse email nao existe."
            redirect_to new_password_reset_path
        end
    end
    
    def edit
        @user = User.find_by(password_reset_token: params[:id]) 
        if @user
        else
            render file: 'public/404.html', status: :not_found
        end
    end
    
    def update
        @user = User.find_by(password_reset_token: params[:id])
        if @user && @user.update_attributes(user_params)
            @user.update_attribute(:password_reset_token, nil)
            session[:user_id] = @user.id
            redirect_to login_path, success: "Senha redefinida."
        else
            flash.now[:notice] = "O link está expirado."
            render action: 'edit'
        end
    end

    private
    
    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
