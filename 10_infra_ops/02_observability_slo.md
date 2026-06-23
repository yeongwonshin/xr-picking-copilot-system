# Observability & SLO

## Golden Signals
- Latency: 스캔 → 검증 결과 p95
- Traffic: 초당 검증 이벤트 수
- Errors: WMS 확정 실패율, 앱 크래시율
- Saturation: Edge GPU/CPU, 이벤트 큐 lag

## 주요 SLO
| 항목 | 목표 |
|---|---|
| XR API availability | 99.9% |
| Verification p95 latency | 500ms 이하 |
| WMS confirm success | 99.5% 이상 |
| Event loss | 0건 목표 |
| Device heartbeat freshness | 60초 이내 |
| Ops console dashboard delay | 30초 이하 |

## 로그 필드
- trace_id
- tenant_id
- warehouse_id
- worker_id pseudonymized
- device_id
- pick_line_id
- event_type
- result
- latency_ms
- model_version

## 알림
| 조건 | 알림 대상 |
|---|---|
| WMS confirm failure > 1% 5분 지속 | IT Admin |
| Edge Node heartbeat lost 2분 | Supervisor + IT |
| 오피킹 경고 급증 | Supervisor |
| 특정 SKU 재스캔률 급증 | QA/WMS Admin |
| 앱 크래시율 급증 | Product/Engineering |
