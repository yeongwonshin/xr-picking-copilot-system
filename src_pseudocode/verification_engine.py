"""
Verification engine pseudocode for XR Picking Copilot.
Combines deterministic scan checks with AI visual confidence.
"""

from dataclasses import dataclass
from typing import Optional

@dataclass
class ExpectedContext:
    sku_id: str
    gtin: str
    location_id: str
    tote_id: str
    quantity: int

@dataclass
class ObservedSignal:
    scanned_gtin: Optional[str]
    scanned_location: Optional[str]
    scanned_tote: Optional[str]
    visual_sku_id: Optional[str]
    visual_confidence: float
    quantity: Optional[int]


def verify(expected: ExpectedContext, observed: ObservedSignal) -> dict:
    failures = []
    warnings = []

    if observed.scanned_location and observed.scanned_location != expected.location_id:
        failures.append('LOCATION_MISMATCH')

    if observed.scanned_gtin and observed.scanned_gtin != expected.gtin:
        failures.append('SKU_BARCODE_MISMATCH')

    if observed.scanned_tote and observed.scanned_tote != expected.tote_id:
        failures.append('TOTE_MISMATCH')

    if observed.quantity is not None and observed.quantity != expected.quantity:
        warnings.append('QUANTITY_DIFFERS')

    if observed.visual_sku_id:
        if observed.visual_sku_id != expected.sku_id and observed.visual_confidence >= 0.85:
            failures.append('VISUAL_SKU_MISMATCH')
        elif observed.visual_confidence < 0.70:
            warnings.append('LOW_VISUAL_CONFIDENCE')

    if failures:
        result = 'FAIL'
    elif warnings:
        result = 'WARN'
    else:
        result = 'PASS'

    return {
        'result': result,
        'failures': failures,
        'warnings': warnings,
        'visual_confidence': observed.visual_confidence,
    }
