require 'hoe'

HOE = Hoe.spec 'mongrel_service' do
  self.version = '0.4.0.beta1'

  developer 'Luis Lavena', 'luislavena@gmail.com'

  extra_deps << ['gem_plugin', '~> 0.2.3']
  extra_deps << ['mongrel', '~> 1.1.5']
  extra_deps << ['win32-service', '~> 0.5.2']
end