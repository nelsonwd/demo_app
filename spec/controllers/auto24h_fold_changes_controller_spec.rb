require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe Auto24hFoldChangesController do

  # This should return the minimal set of attributes required to create a valid
  # Auto24hFoldChange. As you add validations to Auto24hFoldChange, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  describe "GET index" do
    it "assigns all auto24h_fold_changes as @auto24h_fold_changes" do
      auto24h_fold_change = Auto24hFoldChange.create! valid_attributes
      get :index
      assigns(:auto24h_fold_changes).should eq([auto24h_fold_change])
    end
  end

  describe "GET show" do
    it "assigns the requested auto24h_fold_change as @auto24h_fold_change" do
      auto24h_fold_change = Auto24hFoldChange.create! valid_attributes
      get :show, :id => auto24h_fold_change.id.to_s
      assigns(:auto24h_fold_change).should eq(auto24h_fold_change)
    end
  end

  describe "GET new" do
    it "assigns a new auto24h_fold_change as @auto24h_fold_change" do
      get :new
      assigns(:auto24h_fold_change).should be_a_new(Auto24hFoldChange)
    end
  end

  describe "GET edit" do
    it "assigns the requested auto24h_fold_change as @auto24h_fold_change" do
      auto24h_fold_change = Auto24hFoldChange.create! valid_attributes
      get :edit, :id => auto24h_fold_change.id.to_s
      assigns(:auto24h_fold_change).should eq(auto24h_fold_change)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Auto24hFoldChange" do
        expect {
          post :create, :auto24h_fold_change => valid_attributes
        }.to change(Auto24hFoldChange, :count).by(1)
      end

      it "assigns a newly created auto24h_fold_change as @auto24h_fold_change" do
        post :create, :auto24h_fold_change => valid_attributes
        assigns(:auto24h_fold_change).should be_a(Auto24hFoldChange)
        assigns(:auto24h_fold_change).should be_persisted
      end

      it "redirects to the created auto24h_fold_change" do
        post :create, :auto24h_fold_change => valid_attributes
        response.should redirect_to(Auto24hFoldChange.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved auto24h_fold_change as @auto24h_fold_change" do
        # Trigger the behavior that occurs when invalid params are submitted
        Auto24hFoldChange.any_instance.stub(:save).and_return(false)
        post :create, :auto24h_fold_change => {}
        assigns(:auto24h_fold_change).should be_a_new(Auto24hFoldChange)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Auto24hFoldChange.any_instance.stub(:save).and_return(false)
        post :create, :auto24h_fold_change => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested auto24h_fold_change" do
        auto24h_fold_change = Auto24hFoldChange.create! valid_attributes
        # Assuming there are no other auto24h_fold_changes in the database, this
        # specifies that the Auto24hFoldChange created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Auto24hFoldChange.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => auto24h_fold_change.id, :auto24h_fold_change => {'these' => 'params'}
      end

      it "assigns the requested auto24h_fold_change as @auto24h_fold_change" do
        auto24h_fold_change = Auto24hFoldChange.create! valid_attributes
        put :update, :id => auto24h_fold_change.id, :auto24h_fold_change => valid_attributes
        assigns(:auto24h_fold_change).should eq(auto24h_fold_change)
      end

      it "redirects to the auto24h_fold_change" do
        auto24h_fold_change = Auto24hFoldChange.create! valid_attributes
        put :update, :id => auto24h_fold_change.id, :auto24h_fold_change => valid_attributes
        response.should redirect_to(auto24h_fold_change)
      end
    end

    describe "with invalid params" do
      it "assigns the auto24h_fold_change as @auto24h_fold_change" do
        auto24h_fold_change = Auto24hFoldChange.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Auto24hFoldChange.any_instance.stub(:save).and_return(false)
        put :update, :id => auto24h_fold_change.id.to_s, :auto24h_fold_change => {}
        assigns(:auto24h_fold_change).should eq(auto24h_fold_change)
      end

      it "re-renders the 'edit' template" do
        auto24h_fold_change = Auto24hFoldChange.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Auto24hFoldChange.any_instance.stub(:save).and_return(false)
        put :update, :id => auto24h_fold_change.id.to_s, :auto24h_fold_change => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested auto24h_fold_change" do
      auto24h_fold_change = Auto24hFoldChange.create! valid_attributes
      expect {
        delete :destroy, :id => auto24h_fold_change.id.to_s
      }.to change(Auto24hFoldChange, :count).by(-1)
    end

    it "redirects to the auto24h_fold_changes list" do
      auto24h_fold_change = Auto24hFoldChange.create! valid_attributes
      delete :destroy, :id => auto24h_fold_change.id.to_s
      response.should redirect_to(auto24h_fold_changes_url)
    end
  end

end
