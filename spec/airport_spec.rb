require 'airport'

describe Airport do 
  subject(:airport) { described_class.new(30) }
  let(:plane) { double :plane }

  describe '#land' do
    it 'instructs a plane to land' do
      allow(airport).to receive(:stormy?).and_return false
      expect(airport).to respond_to(:land).with(1).argument
    end

    context 'when full' do
      it 'does not allow landing' do 
        allow(airport).to receive(:stormy?).and_return false
        30.times do 
          airport.land(plane)
        end 
        expect { airport.land(plane) }.to raise_error "Airport full: Cannot land plane"
      end
    end 

      it 'raises an error if asked to land a plane when stormy' do
        allow(airport).to receive(:stormy?).and_return true
        expect { airport.land(plane) }.to raise_error "Cannot land plane: weather is stormy"
      end 
  end 

  describe '#take_off' do 

    it 'instructs a plane to take off' do
      expect(airport).to respond_to(:take_off).with(1).argument
    end
    
    it 'confirms that a plane is no longer at the airport' do
      airport.land(plane)
      taking_off = airport.take_off(plane)
      expect(taking_off).to eq "Plane has taken off"
    end
  end

  context 'defaults' do
    
    it 'has a default capacity' do
      allow(airport).to receive(:stormy?).and_return false
      described_class::DEFAULT_CAPACITY.times { airport.land(plane) }
      expect{ airport.land(plane) }.to raise_error "Airport full: Cannot land plane"
    end
  end

end
