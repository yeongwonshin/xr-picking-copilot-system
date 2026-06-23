# Edge Runtime Specification

## 역할
Edge Node는 창고 내부에서 저지연 AI 추론과 로컬 캐시를 담당한다. 네트워크가 불안정해도 작업자 경험을 유지하고, 원본 영상이 외부로 나가지 않도록 개인정보 리스크를 줄인다.

## 기능
- 카메라 프레임 수신 및 샘플링
- 바코드/QR 디코딩 보조
- SKU 객체 탐지 및 이미지 임베딩 추론
- 작업 컨텍스트 기반 검증
- 오프라인 작업 큐 캐시
- 이벤트 로컬 큐와 재전송
- 모델 버전 관리 및 rollback

## 권장 하드웨어 범주
- GPU/AI accelerator가 있는 산업용 edge box
- 창고 온도/먼지/진동 조건 대응
- 이중 NIC, TPM, disk encryption 지원
- UPS 또는 전원 장애 대응 옵션

## 런타임 구성
```text
edge-runtime/
├── frame-ingestion-service
├── barcode-decoder
├── visual-verifier
├── local-cache-broker
├── sync-agent
├── model-manager
└── device-health-agent
```

## 로컬 저장 정책
- 원본 영상: 기본 저장 안 함
- 예외 상황 스냅샷: 고객 설정에 따라 blur/crop 후 단기 저장
- 이벤트 메타데이터: 30~90일 또는 고객 정책
- 모델 파일: 서명 검증 후 설치

## 장애 대응
| 장애 | 대응 |
|---|---|
| 클라우드 연결 끊김 | 로컬 큐 저장, 캐시 작업 진행 |
| AI 모델 오류 | 이전 안정 버전 rollback |
| Edge Node 다운 | Glass가 바코드-only 모드로 fallback |
| 디스크 부족 | 원본/스냅샷 우선 삭제, 이벤트 큐 보호 |
