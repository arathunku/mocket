require 'spec_helper'

describe UsersController do
  describe "access to user sites" do
    [:dashboard, :archives, :favorites].each do |site|
      it "not logged" do
        get site
        expect(response.status).to eq(302)
      end

      it "logged but not invited" do
        user = FactoryGirl.create(:user, invited: false)
        session[:user_id] = user.id
        get site
        expect(response.status).to eq(302)
      end

      it "logged and invited" do
        user = FactoryGirl.create(:user, invited: true)
        session[:user_id] = user.id
        get site
        expect(response.status).to eq(200)
      end
    end
  end

  describe "actions" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      Post.any_instance.stub(:fillup_song)
      @post = FactoryGirl.build(:post, user: @user)
      session[:user_id] = @user.id
    end

    describe "#new_song" do
      it "return 422 for empty search" do
        @post.search = ''
        Post.should_receive(:new).and_return(@post)
        post :new_song, {post: {}}
        expect(response.status).to eq(302)
        expect(flash[:error]).to eq('Missing search.')
      end

      it "creats post proper" do
        hash = {post: {search: @post.search}}
        Post.should_receive(:new).with({
          "search"=> @post.search
        }).and_return(@post)
        Post.any_instance.should_receive(:save).and_return(@post)
        post :new_song, hash
        expect(response.status).to eq(302)
      end
    end

    context "actions on posts" do
      before(:each) do
        Post.stub(:find).with(@post.id).and_return(@post)
      end

      describe "#favorite_song" do
        it "favorite post" do
          Post.any_instance.should_receive(:update_attributes).with(favorite: true)
          put :favorite, id: @post.id
        end

        it "unfavorite post" do
          @post.favorite = true
          Post.stub(:find).with(@post.id).and_return(@post)
          Post.any_instance.should_receive(:update_attributes).with(favorite: false)
          put :favorite, id: @post.id
        end

        it "redirects correctly" do
          Post.any_instance.stub(:update_attributes).and_return(true)
          put :favorite, id: @post.id
          expect(response.status).to eq(302)
        end
      end

      describe "#archive_song" do
        it "archives post" do
          Post.any_instance.should_receive(:update_attributes).with(archived: true)
          put :archive, id: @post.id
        end

        it "unarchives post" do
          @post.archived = true
          Post.stub(:find).with(@post.id).and_return(@post)
          Post.any_instance.should_receive(:update_attributes).with(archived: false)
          put :archive, id: @post.id
        end

        it "redirects correctly" do
          Post.any_instance.stub(:update_attributes).and_return(true)
          put :archive, id: @post.id
          expect(response.status).to eq(302)
        end
      end

      describe "destroy_song" do
        it "destroys post" do
          Post.any_instance.should_receive(:destroy).and_return(true)
          delete :destroy_song, id: @post.id
        end

        it "redirects correctly" do
          Post.any_instance.stub(:update_attributes)
          delete :destroy_song, id: @post.id
          expect(response.status).to eq(302)
        end
      end
    end

    describe "#dashboard" do
      before(:each) do
        FactoryGirl.create(:post)
      end

      it "paging #1" do
        @posts = []
        (1..14).each do |i|
          @posts.push(
            FactoryGirl.create(:post, search: "#{i}", user: @user,
              created_at: Time.now-i.minutes)
          )
        end
        get :dashboard
        expect(assigns(:posts).length).to eq(5)
      end

      it "paging #2" do
        @posts = []
        (1..14).each do |i|
          @posts.push(
            FactoryGirl.create(:post, search: "#{i}", user: @user,
              created_at: Time.now-i.minutes)
          )
        end
        get :dashboard, page: 3
        expect(assigns(:posts).length).to eq(4)
      end

      it "assign posts in descending order" do
        post_newest = FactoryGirl.create(:post, user: @user,
          created_at: Time.now+2.hour)
        post_older = FactoryGirl.create(:post, user: @user,
          created_at: Time.now+1.hour)
        get :dashboard
        expect(assigns(:posts)).to eq([post_newest, post_older])
      end
    end
  end
end
