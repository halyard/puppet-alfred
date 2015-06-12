require 'spec_helper'

describe 'alfred' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "alfred class without any parameters" do
          let(:params) {{ }}

          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('alfred::params') }
          it { is_expected.to contain_class('alfred::install').that_comes_before('alfred::config') }
          it { is_expected.to contain_class('alfred::config') }
          it { is_expected.to contain_class('alfred::service').that_subscribes_to('alfred::config') }

          it { is_expected.to contain_service('alfred') }
          it { is_expected.to contain_package('alfred').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'alfred class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { is_expected.to contain_package('alfred') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
