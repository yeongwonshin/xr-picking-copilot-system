# Event Contracts

## 공통 헤더
```json
{
  "event_id": "evt_01J...",
  "event_type": "PickLineVerified",
  "tenant_id": "tenant_acme",
  "warehouse_id": "WH-SEOUL-01",
  "trace_id": "trace_abc",
  "idempotency_key": "pickline-123-verified-v1",
  "occurred_at": "2026-06-24T10:11:12+09:00",
  "schema_version": "1.0"
}
```

## PickLineVerified
```json
{
  "pick_line_id": "PL-10001",
  "pick_task_id": "PT-20001",
  "worker_id": "W-083",
  "device_id": "GLASS-009",
  "expected_sku": "SKU-000123",
  "observed_sku": "SKU-000123",
  "quantity": 2,
  "uom": "EA",
  "location_id": "A-03-02-B",
  "tote_id": "TOTE-17",
  "verification": {
    "barcode_result": "PASS",
    "visual_result": "PASS",
    "visual_confidence": 0.97
  }
}
```

## PickExceptionRaised
```json
{
  "exception_id": "EX-9001",
  "pick_line_id": "PL-10002",
  "exception_type": "STOCKOUT",
  "severity": "MEDIUM",
  "worker_note": "빈 위치에 재고 없음",
  "suggested_action": "CHECK_ALTERNATE_LOCATION"
}
```

## DeviceHeartbeat
```json
{
  "device_id": "GLASS-009",
  "worker_id": "W-083",
  "battery_pct": 64,
  "temperature_c": 37.5,
  "wifi_rssi": -58,
  "app_version": "1.4.2",
  "model_version": "sku-verifier-2026.06.1",
  "status": "ACTIVE"
}
```
