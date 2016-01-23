Fabricator(:admin) do
  email 'test@test.com'
  password SecureRandom.base64(36)
end
