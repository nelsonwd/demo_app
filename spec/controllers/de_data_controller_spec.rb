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

describe DeDataController do

  # This should return the minimal set of attributes required to create a valid
  # DeDatum. As you add validations to DeDatum, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  describe "GET index" do
    it "assigns all de_data as @de_data" do
      de_datum = DeDatum.create! valid_attributes
      get :index
      assigns(:de_data).should eq([de_datum])
    end
  end

  describe "GET show" do
    it "assigns the requested de_datum as @de_datum" do
      de_datum = DeDatum.create! valid_attributes
      get :show, :id => de_datum.id.to_s
      assigns(:de_datum).should eq(de_datum)
    end
  end

  describe "GET new" do
    it "assigns a new de_datum as @de_datum" do
      get :new
      assigns(:de_datum).should be_a_new(DeDatum)
    end
  end

  describe "GET edit" do
    it "assigns the requested de_datum as @de_datum" do
      de_datum = DeDatum.create! valid_attributes
      get :edit, :id => de_datum.id.to_s
      assigns(:de_datum).should eq(de_datum)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new DeDatum" do
        expect {
          post :create, :de_datum => valid_attributes
        }.to change(DeDatum, :count).by(1)
      end

      it "assigns a newly created de_datum as @de_datum" do
        post :create, :de_datum => valid_attributes
        assigns(:de_datum).should be_a(DeDatum)
        assigns(:de_datum).should be_persisted
      end

      it "redirects to the created de_datum" do
        post :create, :de_datum => valid_attributes
        response.should redirect_to(DeDatum.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved de_datum as @de_datum" do
        # Trigger the behavior that occurs when invalid params are submitted
        DeDatum.any_instance.stub(:save).and_return(false)
        post :create, :de_datum => {}
        assigns(:de_datum).should be_a_new(DeDatum)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        DeDatum.any_instance.stub(:save).and_return(false)
        post :create, :de_datum => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested de_datum" do
        de_datum = DeDatum.create! valid_attributes
        # Assuming there are no other de_data in the database, this
        # specifies that the DeDatum created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        DeDatum.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => de_datum.id, :de_datum => {'these' => 'params'}
      end

      it "assigns the requested de_datum as @de_datum" do
        de_datum = DeDatum.create! valid_attributes
        put :update, :id => de_datum.id, :de_datum => valid_attributes
        assigns(:de_datum).should eq(de_datum)
      end

      it "redirects to the de_datum" do
        de_datum = DeDatum.create! valid_attributes
        put :update, :id => de_datum.id, :de_datum => valid_attributes
        response.should redirect_to(de_datum)
      end
    end

    describe "with invalid params" do
      it "assigns the de_datum as @de_datum" do
        de_datum = DeDatum.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        DeDatum.any_instance.stub(:save).and_return(false)
        put :update, :id => de_datum.id.to_s, :de_datum => {}
        assigns(:de_datum).should eq(de_datum)
      end

      it "re-renders the 'edit' template" do
        de_datum = DeDatum.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        DeDatum.any_instance.stub(:save).and_return(false)
        put :update, :id => de_datum.id.to_s, :de_datum => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested de_datum" do
      de_datum = DeDatum.create! valid_attributes
      expect {
        delete :destroy, :id => de_datum.id.to_s
      }.to change(DeDatum, :count).by(-1)
    end

    it "redirects to the de_data list" do
      de_datum = DeDatum.create! valid_attributes
      delete :destroy, :id => de_datum.id.to_s
      response.should redirect_to(de_data_url)
    end
  end

end