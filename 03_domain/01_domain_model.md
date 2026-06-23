# Domain Model

## 핵심 엔티티
| 엔티티 | 설명 |
|---|---|
| Warehouse | 창고 단위. 주소, 시간대, 운영 캘린더 포함 |
| Zone | 창고 내 작업 영역. 냉장/상온/위험물 등 속성 포함 |
| Location | 랙, 빈, 셀. QR/바코드/좌표/접근 난이도 포함 |
| SKU | 상품 또는 부품. GTIN, 이미지, 크기, 무게, 유사 SKU 그룹 포함 |
| InventoryLot | 로트/유통기한/시리얼 관리 단위 |
| Order | 고객 주문 또는 출고 지시 |
| PickWave | 여러 주문을 묶은 작업 배치 |
| PickTask | 작업자에게 할당되는 작업 단위 |
| PickLine | SKU, 수량, 로케이션 기준 피킹 라인 |
| Tote | 멀티오더 피킹용 바구니/박스 |
| Device | 글래스, 스캐너, 엣지 노드 |
| Worker | 작업자. 권한, 숙련도, 인증 상태 포함 |
| VerificationEvent | 스캔/AI/수량/토트 검증 결과 |
| ExceptionCase | 재고 부족, 오피킹, 장비 장애 등 예외 |

## 상태 모델
### PickLine Status
```text
CREATED -> ASSIGNED -> NAVIGATING -> AT_LOCATION -> VERIFYING -> PICKED -> PACKED -> CONFIRMED
                         |              |             |
                         v              v             v
                      SKIPPED       EXCEPTION      REWORK_REQUIRED
```

### Verification Result
- `PASS`: 스캔/AI/룰 모두 통과
- `WARN`: AI 신뢰도 낮음, 보조 검증 필요
- `FAIL`: SKU/로케이션/수량/토트 불일치
- `OVERRIDE`: 관리자 승인으로 진행

## 이벤트 원칙
- 모든 이벤트는 `tenant_id`, `warehouse_id`, `trace_id`, `idempotency_key`를 가진다.
- WMS 반영 이벤트는 중복 전송되어도 한 번만 처리되도록 설계한다.
- 영상 원본이 아닌 메타데이터 중심으로 이벤트를 남긴다.
