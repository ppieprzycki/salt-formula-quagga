quagga:
  zebra:
    password: "password123"
    enable_password: "enablepass123"
  bgpd:
    password: "password123"
    enable_password: "enablepass123"
    router_asn: '2134'
    router_id: '192.168.1.1'
    redistribute: 
      connected:
    maximum_paths: 2
    log_neighbor_changes: true
    graceful_restart: true
    deterministic_med: true
    timers: 
      keepalive: 30
      holdtime: 90
    networks:
      - '1.2.3.4/32'
      - '2.3.4.5/32'
    neighbours:
      - address: '192.168.1.3'
        remote_as: '12345'
        description: 'example router1'
        password: 'pass1'
        route_map:
          in: 'priv-peer-import'
          out: 'priv-peer-export'
      - address: '192.168.1.4'
        remote_as: '12345'
        description: 'example router2'
        soft_reconfiguration: inbound
  prefix_list:
    prefixlist1:
      - action: 'permit'
        entry: '30.185.12.193/32'
      - action: 'permit'
        entry: '40.185.12.193/32'
      - action: 'deny'
        entry: 'any'
    prefixlist2:
      - action: 'permit'
        entry: '32.185.12.193/32'
      - action: 'permit'
        entry: '42.185.12.193/32'
      - action: 'deny'
        entry: 'any'
  route_map:
    'priv-peer-import':
      - action: 'permit'
        match_ip_address_prefix_list: prefixlist1
      - action: 'deny'
    'priv-peer-export':
      - action: 'deny'
    'priv-peer-tes-set':
      - action: 'permit'
        match_ip_address_prefix_list: prefixlist2
        set_local_preference: 101 
        set_metric: 101 
      - action: 'deny'
