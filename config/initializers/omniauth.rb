Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '398737900141782', '3d45a7ca7ed74f0dbdbf6656abbfd107'
end