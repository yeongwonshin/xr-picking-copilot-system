# Model Card — SKU Visual Verification

## 모델 목적
피킹 중 카메라 프레임에서 상품 또는 라벨 영역을 인식하고, 현재 작업 지시의 예상 SKU와 일치할 가능성을 산출한다.

## 권장 모델 조합
- Barcode-first deterministic validation
- Lightweight object detector for package/label region
- Embedding model for SKU visual similarity
- Rule engine for final decision

## 사용하면 좋은 경우
- 유사 SKU가 많아 바코드 스캔 전 확인이 필요한 경우
- 라벨 위치가 일정하고 SKU 마스터 이미지가 확보된 경우
- 작업자가 핸드스캐너 없이 hands-free로 작업해야 하는 경우

## 사용하면 안 되는 경우
- SKU 외관이 거의 동일하고 바코드만 다른 경우
- 조도가 매우 낮거나 반사 포장이 많은 경우
- 카메라가 작업물을 충분히 볼 수 없는 공정

## 성능 목표
| 지표 | 목표 |
|---|---|
| Visual top-1 후보 정확도 | 95% 이상 |
| 오피킹 차단 재현율 | 98% 이상 |
| 정상 작업 오차단률 | 1% 이하 |
| 추론 지연 | 300ms 이하 |
| 모델 커버리지 | 상위 피킹량 SKU 80% 이상 |

## 위험과 완화
- 패키지 리뉴얼: SKU 이미지 드리프트 감지 및 재촬영 워크플로우
- 개인정보: 작업자 얼굴 crop 자동 폐기
- 데이터 편향: 특정 조도·작업자·존에 치우치지 않도록 샘플링
- 오차단 피로: AI 단독 차단보다 바코드/재스캔과 결합

## 배포
- Edge Node에서 ONNX/TensorRT/OpenVINO 최적화 모델 운영
- Model Registry에서 버전 관리
- Canary 배포 후 오류율 비교
