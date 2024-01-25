local ok, mp = pcall(require, 'markdown-preview')
if not ok then
  return
end

mp.setup {}
