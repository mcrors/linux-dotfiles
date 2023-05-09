local nvim_comment_status_ok, nvim_comment = pcall(require, "nvim_comment")
if not nvim_comment_status_ok then
  return
end

nvim_comment.setup(
    {
        line_mapping = "<leader>cl",
        operator_mapping = "<leader>cm"
    }
)
