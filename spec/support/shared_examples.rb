shared_examples "require login" do 
  it 'redirects to the root path' do
    clear_current_user
    action
    response.should redirect_to root_path
  end

  it 'displays a flash message' do
    clear_current_user
    action
    expect(flash[:alert]).to eq('You must first sign in to access this page.')
  end
end