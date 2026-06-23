# Data Annotation Guide

## 라벨링 단위
- SKU 패키지 bbox
- 바코드/QR 라벨 bbox
- 토트/박스 bbox
- 로케이션 라벨 bbox
- 손/장갑 가림 여부

## 필수 메타데이터
```json
{
  "warehouse_id": "WH-SEOUL-01",
  "zone_id": "A",
  "location_id": "A-03-02-B",
  "sku_id": "SKU-000123",
  "gtin": "8801234567890",
  "lighting": "normal|low|glare",
  "blur": "none|motion|out_of_focus",
  "packaging_version": "2026-Q1",
  "is_hard_negative": false
}
```

## 품질 기준
- bbox는 상품 외곽에 5% 이내 여백
- 유사 SKU는 반드시 hard negative 그룹으로 표시
- 손상 라벨, 찌그러진 박스, 반사 포장은 별도 condition 라벨 부여
- 학습/검증/테스트는 창고·날짜 기준으로 분리하여 누출 방지

## 샘플링 전략
- 피킹량 상위 20% SKU 우선
- 오류 빈도 상위 SKU 우선
- 동일 SKU라도 조도/거리/각도를 다양화
- 패키지 리뉴얼 시 기존 버전과 새 버전 모두 보관
