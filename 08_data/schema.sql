-- XR Picking Copilot reference schema

CREATE TABLE tenants (
  tenant_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  plan TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE warehouses (
  warehouse_id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL REFERENCES tenants(tenant_id),
  name TEXT NOT NULL,
  timezone TEXT NOT NULL DEFAULT 'Asia/Seoul'
);

CREATE TABLE locations (
  location_id TEXT PRIMARY KEY,
  warehouse_id TEXT NOT NULL REFERENCES warehouses(warehouse_id),
  zone_id TEXT NOT NULL,
  aisle TEXT,
  rack TEXT,
  bin TEXT,
  qr_value TEXT UNIQUE,
  x_m NUMERIC,
  y_m NUMERIC,
  z_m NUMERIC,
  risk_level TEXT DEFAULT 'NORMAL'
);

CREATE TABLE skus (
  sku_id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL REFERENCES tenants(tenant_id),
  gtin TEXT,
  name TEXT NOT NULL,
  barcode_aliases JSONB DEFAULT '[]',
  image_urls JSONB DEFAULT '[]',
  weight_g NUMERIC,
  dimensions_mm JSONB,
  similar_sku_group TEXT,
  is_ai_supported BOOLEAN DEFAULT false
);

CREATE TABLE pick_tasks (
  pick_task_id TEXT PRIMARY KEY,
  warehouse_id TEXT NOT NULL REFERENCES warehouses(warehouse_id),
  wave_id TEXT,
  worker_id TEXT,
  status TEXT NOT NULL,
  priority INTEGER NOT NULL DEFAULT 100,
  assigned_at TIMESTAMPTZ
);

CREATE TABLE pick_lines (
  pick_line_id TEXT PRIMARY KEY,
  pick_task_id TEXT NOT NULL REFERENCES pick_tasks(pick_task_id),
  order_id TEXT NOT NULL,
  sku_id TEXT NOT NULL REFERENCES skus(sku_id),
  location_id TEXT NOT NULL REFERENCES locations(location_id),
  requested_qty NUMERIC NOT NULL,
  picked_qty NUMERIC DEFAULT 0,
  uom TEXT NOT NULL DEFAULT 'EA',
  tote_id TEXT,
  status TEXT NOT NULL DEFAULT 'CREATED'
);

CREATE TABLE verification_events (
  event_id TEXT PRIMARY KEY,
  pick_line_id TEXT NOT NULL REFERENCES pick_lines(pick_line_id),
  event_type TEXT NOT NULL,
  expected_value TEXT,
  observed_value TEXT,
  confidence NUMERIC,
  result TEXT NOT NULL,
  worker_id TEXT,
  device_id TEXT,
  idempotency_key TEXT NOT NULL UNIQUE,
  occurred_at TIMESTAMPTZ NOT NULL
);

CREATE TABLE exception_cases (
  exception_id TEXT PRIMARY KEY,
  pick_line_id TEXT NOT NULL REFERENCES pick_lines(pick_line_id),
  exception_type TEXT NOT NULL,
  severity TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'OPEN',
  note TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  resolved_at TIMESTAMPTZ
);

CREATE TABLE devices (
  device_id TEXT PRIMARY KEY,
  warehouse_id TEXT NOT NULL REFERENCES warehouses(warehouse_id),
  device_type TEXT NOT NULL,
  serial_no TEXT,
  app_version TEXT,
  model_version TEXT,
  status TEXT NOT NULL DEFAULT 'READY',
  last_heartbeat_at TIMESTAMPTZ
);
