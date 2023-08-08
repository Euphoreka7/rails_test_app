require 'rails_helper'

describe Api::V1::ExperimentsController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/api/v1/experiments").to route_to("api/v1/experiments#index")
    end
  end

  describe '#index' do
    let(:device_token) { SecureRandom.uuid }

    let!(:experiment_1) { create(:experiment, name: "button_color") }
    let!(:experiment_1_option1) { create(:experiment_option, experiment: experiment_1, value: '#FF0000', percentage: 33.3) }
    let!(:experiment_1_option2) { create(:experiment_option, experiment: experiment_1, value: '#00FF00', percentage: 33.3) }
    let!(:experiment_1_option3) { create(:experiment_option, experiment: experiment_1, value: '#0000FF', percentage: 33.3) }


    let!(:experiment_2) { create(:experiment, name: "price") }
    let!(:experiment_2_option_1) { create(:experiment_option, experiment: experiment_2, value: '10', percentage: 75) }
    let!(:experiment_2_option_2) { create(:experiment_option, experiment: experiment_2, value: '20', percentage: 10) }
    let!(:experiment_2_option_3) { create(:experiment_option, experiment: experiment_2, value: '50', percentage: 5) }
    let!(:experiment_2_option_4) { create(:experiment_option, experiment: experiment_2, value: '5', percentage: 10) }

    context "with the same device token" do
      it 'should create client settings just once' do
        request.headers.merge!("Device-Token" => device_token)
        expect { get :index }.to change { ClientSetting.count }.by(2)
        expect(response).to have_http_status(200)

        response_body = JSON.parse(response.body)
        expect(response_body).to have_key("button_color")
        expect(response_body).to have_key("price")

        expect { get :index }.not_to change { ClientSetting.count }
        expect(JSON.parse(response.body)).to eq(response_body)
      end
    end

    context "with different device tokens" do
      it 'should create client settings for each token' do
        request.headers.merge!("Device-Token" => SecureRandom.uuid)
        expect { get :index }.to change { ClientSetting.count }.by(2)
        expect(response).to have_http_status(200)

        request.headers.merge!("Device-Token" => SecureRandom.uuid)
        expect { get :index }.to change { ClientSetting.count }.by(2)
        expect(response).to have_http_status(200)
      end
    end

    context "with many customers" do
      it "creates corresponding count of price values" do
        settings = Array.new(100) do
          request.headers.merge!("Device-Token" => SecureRandom.uuid); get :index; JSON.parse(response.body)
        end
        result = settings.group_by{|resp| resp["price"]}.transform_values(&:size)
        expect(result).to be_eql({"10"=> 75, "20" => 10, "50" => 5, "5"=> 10})
      end

      it "creates corresponding count of button_color values" do
        settings = Array.new(99) do
          request.headers.merge!("Device-Token" => SecureRandom.uuid); get :index; JSON.parse(response.body)
        end
        result = settings.group_by{|resp| resp["button_color"]}.transform_values(&:size)
        expect(result).to be_eql({'#FF0000'=> 33, '#00FF00' => 33, '#0000FF' => 33})
      end
    end

    context "with existing client settings" do
      let!(:client) { create(:client, device_token: device_token) }
      let!(:client_settings) { create(:client_setting, client: client, experiment: experiment_1, experiment_option: experiment_1_option2) }

      it 'should create client settings for each token' do
        request.headers.merge!("Device-Token" => device_token)
        expect { get :index }.to change { ClientSetting.count }.by(1)
        expect(response).to have_http_status(200)
      end
    end
  end
end
