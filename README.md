# 물류·창고 XR 피킹 코파일럿 — Professional System Directory

## 제품 정의
**XR Picking Copilot**은 작업자가 스마트글래스 또는 산업용 헤드마운트 디스플레이를 착용하고, 피킹·검수·포장·예외처리를 hands-free로 수행하도록 돕는 창고 현장 실행 시스템입니다. 단순 MVP가 아니라 WMS/WES 연동, 엣지 AI 오류 감지, 피킹 경로 최적화, 현장 관제, 감사 로그, 디바이스 관리, 보안·개인정보 보호, 상용 운영 지표까지 포함하는 전문 B2B SaaS/Edge 시스템으로 설계했습니다.

## 핵심 가치 제안
- 작업자 시야에 다음 위치, 이동 경로, SKU 이미지, 수량, 로케이션, 포장 지시를 표시
- 카메라·바코드·QR·음성 명령을 결합해 오피킹, 누락, 수량 오류, 잘못된 포장 순서 감지
- WMS/WES/ERP와 이벤트 기반으로 동기화하여 재고, 주문, 작업 상태를 실시간 반영
- 초보 작업자 교육 시간을 줄이고, 숙련자에게는 동선 최적화와 멀티오더 피킹을 제공
- 창고별 KPI: 피킹 정확도, 라인/시간, 평균 동선, 재작업률, 포장 오류율, 장비 가동률을 대시보드화

## 시스템 범위
1. **XR Worker App**: 글래스 UI, 음성 명령, 스캔, 시야 안내, 오프라인 캐시
2. **Edge AI Node**: 저지연 객체/바코드/손동작/빈 위치 감지, 프라이버시 필터링
3. **Task Orchestrator**: WMS 작업 큐, 우선순위, 배치/웨이브/존 피킹, 경로 최적화
4. **Verification Engine**: SKU-로케이션-수량-포장 순서 검증, 예외 처리
5. **Integration Layer**: WMS/WES/ERP/TMS API, GS1/EPCIS 이벤트, 웹훅, 파일/EDI 연계
6. **Operations Console**: 실시간 작업자 상태, 디바이스 상태, 예외 알림, KPI 분석
7. **Security & Governance**: RBAC, SSO, 감사 로그, 영상 최소수집, 모델 거버넌스

## 상용 패키징
- **Starter**: 단일 창고, 20대 이하 글래스, 기본 피킹/검수, CSV/API 연동
- **Professional**: 다중 존/웨이브 피킹, Edge AI, WMS 양방향 연동, KPI 대시보드
- **Enterprise**: 멀티창고, 고가용성, SSO/SAML, 전용 VPC, 커스텀 모델, SLA, 감사 리포트

## 디렉토리 구조
```text
xr_picking_copilot_professional_system/
├── 00_strategy/
├── 01_product/
├── 02_architecture/
├── 03_domain/
├── 04_xr_ux/
├── 05_ai_vision/
├── 06_integration/
├── 07_api/
├── 08_data/
├── 09_edge_device/
├── 10_infra_ops/
├── 11_security/
├── 12_commercial/
├── 13_quality/
├── 14_backlog/
├── config/
├── src_pseudocode/
└── references/
```

## 참고 기준
- GS1 표준은 글로벌 공급망에서 제품 식별·데이터 공유에 널리 쓰입니다.
- EPCIS/CBV 2.x는 공급망 이벤트 공유를 위한 표준 모델로 활용할 수 있습니다.
- 산업용 스마트글래스 업체들은 물류 피킹, hands-free 작업, 바코드 스캔, 음성 제어를 주요 사용 사례로 제시합니다.
- 보안 기준은 OWASP ASVS, NIST SP 800-53 계열 통제 항목에 맞춰 설계합니다.

상세 출처는 `references/sources.md`를 확인하세요.
