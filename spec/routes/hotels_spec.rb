require 'rails_helper'

describe HotelsController, type: :routing do
  it 'should route to #index' do
    expect(get('/hotels')).to route_to('hotels#index')
  end

  it 'should route to #new' do
    expect(get('/hotels/new')).to route_to('hotels#new')
  end

  it 'should route to #show' do
    expect(get('/hotels/1')).to route_to('hotels#show', id: '1')
  end

  it 'should route to #edit' do
    expect(get('/hotels/1/edit')).to route_to('hotels#edit', id: '1')
  end

  it 'should route to #update' do
    expect(put('/hotels/1')).to route_to('hotels#update', id: '1')
  end

  it 'should route to #destroy' do
    expect(delete('/hotels/1')).to route_to('hotels#destroy', id: '1')
  end
end
