-- local ok, schemastore = pcall(require, 'schemastore')
-- if not ok then
--   return
-- end

return {
  -- schemas = schemastore.json.schemas(),
  validate = { enable = true }
}
