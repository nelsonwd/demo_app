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

describe InterprosController do

  # This should return the minimal set of attributes required to create a valid
  # Interpro. As you add validations to Interpro, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  describe "GET index" do
    it "assigns all interpros as @interpros" do
      interpro = Interpro.create! valid_attributes
      get :index
      assigns(:interpros).should eq([interpro])
    end
  end

  describe "GET show" do
    it "assigns the requested interpro as @interpro" do
      interpro = Interpro.create! valid_attributes
      get :show, :id => interpro.id.to_s
      assigns(:interpro).should eq(interpro)
    end
  end

  describe "GET new" do
    it "assigns a new interpro as @interpro" do
      get :new
      assigns(:interpro).should be_a_new(Interpro)
    end
  end

  describe "GET edit" do
    it "assigns the requested interpro as @interpro" do
      interpro = Interpro.create! valid_attributes
      get :edit, :id => interpro.id.to_s
      assigns(:interpro).should eq(interpro)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Interpro" do
        expect {
          post :create, :interpro => valid_attributes
        }.to change(Interpro, :count).by(1)
      end

      it "assigns a newly created interpro as @interpro" do
        post :create, :interpro => valid_attributes
        assigns(:interpro).should be_a(Interpro)
        assigns(:interpro).should be_persisted
      end

      it "redirects to the created interpro" do
        post :create, :interpro => valid_attributes
        response.should redirect_to(Interpro.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved interpro as @interpro" do
        # Trigger the behavior that occurs when invalid params are submitted
        Interpro.any_instance.stub(:save).and_return(false)
        post :create, :interpro => {}
        assigns(:interpro).should be_a_new(Interpro)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Interpro.any_instance.stub(:save).and_return(false)
        post :create, :interpro => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested interpro" do
        interpro = Interpro.create! valid_attributes
        # Assuming there are no other interpros in the database, this
        # specifies that the Interpro created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Interpro.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => interpro.id, :interpro => {'these' => 'params'}
      end

      it "assigns the requested interpro as @interpro" do
        interpro = Interpro.create! valid_attributes
        put :update, :id => interpro.id, :interpro => valid_attributes
        assigns(:interpro).should eq(interpro)
      end

      it "redirects to the interpro" do
        interpro = Interpro.create! valid_attributes
        put :update, :id => interpro.id, :interpro => valid_attributes
        response.should redirect_to(interpro)
      end
    end

    describe "with invalid params" do
      it "assigns the interpro as @interpro" do
        interpro = Interpro.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Interpro.any_instance.stub(:save).and_return(false)
        put :update, :id => interpro.id.to_s, :interpro => {}
        assigns(:interpro).should eq(interpro)
      end

      it "re-renders the 'edit' template" do
        interpro = Interpro.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Interpro.any_instance.stub(:save).and_return(false)
        put :update, :id => interpro.id.to_s, :interpro => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested interpro" do
      interpro = Interpro.create! valid_attributes
      expect {
        delete :destroy, :id => interpro.id.to_s
      }.to change(Interpro, :count).by(-1)
    end

    it "redirects to the interpros list" do
      interpro = Interpro.create! valid_attributes
      delete :destroy, :id => interpro.id.to_s
      response.should redirect_to(interpros_url)
    end
  end

end
