name_prefix = "tp154"
location    = "North Europe"

network_rules = [
  {
    name                         = "Allow_HTTP"
    priority                     = 100
    direction                    = "Inbound"
    access                       = "Allow"
    protocol                     = "Tcp"
    source_port_range            = "*"
    destination_port_range       = "80"
    source_address_prefixes      = ["0.0.0.0/0"]
    destination_address_prefixes = ["0.0.0.0/0"]
  },
  {
    name                         = "Allow_HTTPS"
    priority                     = 110
    direction                    = "Inbound"
    access                       = "Allow"
    protocol                     = "Tcp"
    source_port_range            = "*"
    destination_port_range       = "443"
    source_address_prefixes      = ["0.0.0.0/0"]
    destination_address_prefixes = ["0.0.0.0/0"]
  },
  {
    name                         = "Allow_SSH"
    priority                     = 120
    direction                    = "Inbound"
    access                       = "Allow"
    protocol                     = "Tcp"
    source_port_range            = "*"
    destination_port_range       = "22"
    source_address_prefixes      = ["176.1.207.164/32"]
    destination_address_prefixes = ["0.0.0.0/0"]
  },
  {
    name                         = "Allow-Django"
    priority                     = 130
    direction                    = "Inbound"
    access                       = "Allow"
    protocol                     = "Tcp"
    source_port_range            = "*"
    destination_port_range       = "8000"
    source_address_prefixes      = ["0.0.0.0/0"]
    destination_address_prefixes = ["0.0.0.0/0"]
  }
]