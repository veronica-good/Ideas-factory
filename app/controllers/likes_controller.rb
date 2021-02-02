class LikesController < ApplicationController
    def create
        idea= Idea.find params[:idea_id] 
        like= Like.new idea: idea, user: current_user
        if !can?(:like, idea)
            flash[:alert]='You can not like your own idea'
        elsif like.save
            flash[:notice]='idea liked'
        else
            flash[:alert]=like.errors.full_messages.join(', ')
        end
        redirect_to ideas_path
    end
    def destroy
        like = current_user.likes.find params[:id]
        if !can?(:destroy, like)
            flash[:alert]= 'You can\'t destroy a like you don\'t own'
        elsif like.destroy
            flash[:notice]='idea unliked' 
        else
            flash[:alert]='Couldn\'t unlike the idea'
        end
        redirect_to ideas_path
    end
end
