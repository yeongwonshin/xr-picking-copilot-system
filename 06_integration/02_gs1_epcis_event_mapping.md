# GS1 / EPCIS Event Mapping

## 목적
다중 고객사·공급망 추적성이 필요한 경우, 내부 피킹 이벤트를 GS1 EPCIS 스타일 이벤트로 매핑한다.

## 내부 이벤트 → EPCIS 개념 매핑
| 내부 이벤트 | EPCIS 이벤트 개념 | 예시 |
|---|---|---|
| LocationScanned | ObjectEvent / Read Point | 작업자가 로케이션 라벨 확인 |
| PickLineVerified | ObjectEvent | 특정 SKU/로트가 피킹됨 |
| TotePacked | AggregationEvent | SKU가 토트/박스에 담김 |
| OrderShipped | ObjectEvent | 박스가 출고됨 |
| InventoryMoved | Transformation/Transaction context | 보충·이동 작업 |

## 예시 이벤트
```json
{
  "eventTime": "2026-06-24T10:11:12+09:00",
  "eventType": "ObjectEvent",
  "action": "OBSERVE",
  "bizStep": "picking",
  "disposition": "in_progress",
  "readPoint": {"id": "urn:epc:id:sgln:8801234.00001.A-03-02-B"},
  "bizLocation": {"id": "urn:epc:id:sgln:8801234.00001.0"},
  "epcList": ["urn:epc:id:sgtin:8801234.056789.0001"],
  "quantityList": [{"epcClass": "urn:epc:class:lgtin:8801234.056789.LOT202606", "quantity": 2, "uom": "EA"}],
  "sourceList": [{"type": "location", "source": "A-03-02-B"}],
  "destinationList": [{"type": "tote", "destination": "TOTE-17"}]
}
```

## 주의 사항
- EPCIS는 외부 추적성 공유가 필요한 고객에게 선택 모듈로 제공한다.
- 내부 작업 운영 이벤트와 외부 공유 이벤트는 분리하여 개인정보와 운영 세부정보 노출을 줄인다.
- GTIN/GLN/SSCC 등 식별자 체계를 고객의 GS1 발급 정책과 맞춘다.
