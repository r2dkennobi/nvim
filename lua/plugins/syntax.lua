return {
  -- Ansible syntax (Treesitter YAML is not Ansible-aware)
  { "pearofducks/ansible-vim", ft = { "yaml.ansible", "ansible" } },

  -- Jinja2 templates (Treesitter Jinja support is limited)
  { "Glench/Vim-Jinja2-Syntax", ft = { "jinja", "jinja2", "htmljinja" } },
}
