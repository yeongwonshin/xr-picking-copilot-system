# WMS Integration Strategy

## 연동 목표
WMS는 재고와 주문의 원천 시스템으로 유지하고, XR Copilot은 작업 실행·검증·현장 이벤트를 담당한다.

## 통합 패턴
| 패턴 | 설명 | 장점 | 단점 |
|---|---|---|---|
| REST API | 작업 수신/확정/예외 처리 | 실시간성 좋음 | WMS API 품질 의존 |
| Webhook/Event | WMS 이벤트 구독 | 확장성 좋음 | 이벤트 설계 필요 |
| SFTP/CSV | 배치 파일 교환 | 레거시 대응 | 실시간성 낮음 |
| DB View | 읽기 전용 작업 조회 | 빠른 PoC | 강한 결합, 보안 이슈 |
| EDI | 대기업/3PL 표준 프로세스 | 기존 체계 활용 | 구현 복잡 |

## 필수 마스터 데이터
- warehouse, zone, location
- SKU, GTIN, barcode aliases
- inventory lot, serial, expiry
- orders, order lines
- carton/tote rules
- worker roles

## 핵심 이벤트
| 내부 이벤트 | WMS 방향 | 설명 |
|---|---|---|
| PickTaskAccepted | XR → WMS | 작업자 수락 |
| PickLineStarted | XR → WMS | 라인 시작 |
| PickLineVerified | XR → WMS | SKU/수량 검증 완료 |
| PickExceptionRaised | XR → WMS | 재고 부족/불일치 등 |
| PickWaveCompleted | XR → WMS | 웨이브 종료 |
| InventoryAdjustmentSuggested | XR → WMS | 재고 불일치 제안 |

## Idempotency
- 모든 확정 이벤트는 `idempotency_key`를 포함한다.
- WMS가 일시적으로 실패하면 retry queue에 넣고 exponential backoff 적용.
- 중복 확정 방지를 위해 `(tenant_id, warehouse_id, pick_line_id, event_type)` unique key 사용.

## 연동 테스트
1. 샘플 작업 수신
2. 위치/상품/수량 검증 이벤트 전송
3. 재고 부족 예외 전송
4. 중복 이벤트 재전송 시 무해성 확인
5. WMS 장애 시 로컬 큐 보존 확인
