# AI Error Detection Design

## 목표
카메라, 바코드/QR, 위치 마커, 작업 맥락을 결합하여 오피킹 가능성을 실시간으로 감지한다.

## 입력 신호
- SKU 바코드/QR 결과
- 로케이션 QR/마커
- 상품 이미지 crop
- 작업 지시: expected_sku, expected_qty, expected_location, target_tote
- 이전 작업 이력: 유사 SKU 오류 빈도, 작업자 재스캔 이력
- 환경 신호: 조도, 모션 블러, 카메라 각도

## 검증 레이어
### 1. Deterministic Validation
- expected_sku == scanned_sku
- expected_location == scanned_location
- picked_qty <= requested_qty
- tote_id matches assigned order/tote

### 2. Visual Similarity Validation
- 카메라 crop에서 SKU 후보 추론
- expected SKU 이미지 임베딩과 비교
- 패키지 색상/로고/형상 특징 활용

### 3. Risk Scoring
```text
risk_score = w1*sku_mismatch + w2*low_visual_confidence + w3*similar_sku_group + w4*worker_history + w5*location_risk
```

## 결과 정책
| 조건 | 시스템 동작 |
|---|---|
| 바코드 PASS + AI PASS | 즉시 완료 |
| 바코드 PASS + AI 낮은 신뢰도 | 조용히 통과 또는 샘플링 검수 |
| 바코드 FAIL | 즉시 경고, 완료 차단 |
| AI FAIL + 바코드 미스캔 | 바코드 스캔 요청 |
| 반복 불일치 | 관리자 호출 |

## 모델 구성
- Object Detection: SKU/패키지/라벨 위치 탐지
- OCR/Barcode Assist: 손상 라벨 보조 인식
- Image Embedding: 유사 SKU 비교
- Anomaly Detection: 예상과 다른 포장/토트 상태 탐지

## 데이터 전략
- SKU 마스터 이미지: 정면, 측면, 박스, 라벨
- 현장 이미지: 조도, 거리, 흔들림, 부분 가림 포함
- Hard negative: 유사 SKU, 리뉴얼 패키지, 크기만 다른 SKU
- 데이터 라벨: sku_id, bbox, location_id, condition, confidence

## 운영 지표
- False Block Rate: 정상 작업 차단률
- False Pass Rate: 오피킹 통과율
- Rescan Rate: 재스캔 비율
- Model Coverage: AI 검증 가능 SKU 비율
- Drift Alert: SKU 패키지 변경 감지
