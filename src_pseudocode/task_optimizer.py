"""
Task optimizer pseudocode for XR Picking Copilot.
This is a reference algorithm, not production code.
"""

from dataclasses import dataclass
from typing import List

@dataclass
class PickLine:
    pick_line_id: str
    location_id: str
    sku_id: str
    priority: int
    deadline_minutes: int
    x: float
    y: float
    similar_sku_risk: float

@dataclass
class WorkerContext:
    worker_id: str
    current_x: float
    current_y: float
    zone_id: str
    skill_score: float


def distance(a_x: float, a_y: float, b_x: float, b_y: float) -> float:
    return ((a_x - b_x) ** 2 + (a_y - b_y) ** 2) ** 0.5


def score_line(line: PickLine, worker: WorkerContext) -> float:
    travel_cost = distance(worker.current_x, worker.current_y, line.x, line.y)
    urgency_bonus = max(0, 120 - line.deadline_minutes) * 0.5
    priority_bonus = (100 - line.priority) * 1.5
    risk_penalty = line.similar_sku_risk * 10
    return priority_bonus + urgency_bonus - travel_cost - risk_penalty


def choose_next_lines(lines: List[PickLine], worker: WorkerContext, limit: int = 10) -> List[PickLine]:
    """Return next recommended pick lines for the worker."""
    ranked = sorted(lines, key=lambda line: score_line(line, worker), reverse=True)
    selected = []
    used_similar_groups = set()

    for line in ranked:
        # Avoid putting too many high-risk similar SKUs back-to-back.
        risk_bucket = line.sku_id.split('-')[0]
        if line.similar_sku_risk > 0.8 and risk_bucket in used_similar_groups:
            continue
        selected.append(line)
        used_similar_groups.add(risk_bucket)
        if len(selected) >= limit:
            break

    return selected
