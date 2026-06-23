# Deployment Topology

## 창고 현장 구성
```text
[Smart Glasses]
  ├─ Wi-Fi 6/6E
  ├─ Bluetooth scanner optional
  └─ Voice + camera + display

[Warehouse LAN]
  ├─ Edge AI Node GPU/accelerator
  ├─ Local cache broker
  ├─ Device update proxy
  └─ WMS connector gateway

[Cloud / VPC]
  ├─ API Gateway
  ├─ Task Orchestrator
  ├─ Verification Service
  ├─ Ops Console
  ├─ Analytics DB
  ├─ Model Registry
  └─ Observability Stack
```

## Edge 우선 원칙
- 피킹 순간의 오류 감지는 네트워크 왕복 지연에 민감하므로 가능한 한 Edge에서 수행한다.
- 클라우드는 작업 큐, 장기 분석, 모델 관리, 대시보드에 집중한다.
- 네트워크 장애 시 글래스는 캐시된 작업 일부를 진행하고, 동기화 충돌은 복구 큐에서 처리한다.

## HA 설계
- Cloud 서비스: 다중 AZ, 무중단 롤링 배포
- Edge Node: 이중화 옵션, watchdog, 로컬 큐 영속화
- WMS 연동: idempotency key, retry, dead-letter queue

## 주요 네트워크 포트 예시
| 구간 | 프로토콜 | 용도 |
|---|---|---|
| Glass → XR API | HTTPS/WSS | 작업 카드, 세션, 텔레메트리 |
| Glass → Edge | gRPC/HTTPS | 영상 메타데이터, 스캔 검증 |
| Edge → Cloud | MQTT/HTTPS | 이벤트, 모델 업데이트 |
| Integration → WMS | REST/SOAP/SFTP | 작업/재고/확정 이벤트 |
