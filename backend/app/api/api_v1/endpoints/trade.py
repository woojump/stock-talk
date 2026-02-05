from fastapi import APIRouter, Header, HTTPException, Depends, Query
from app.services.kiwoom import kiwoom_service
from pydantic import BaseModel
from typing import Optional

router = APIRouter()

class OrderRequest(BaseModel):
    ticker: str
    qty: int
    price: int
    is_buy : bool = True    # True: 매수, False: 매도

# 정정 주문 요청 모델
class AmendRequest(BaseModel):
    orig_ord_no: str       # 취소/정정할 원 주문번호
    ticker: str
    qty: int
    price: int

# 취소 주문 요청 모델
class CancelRequest(BaseModel):
    orig_ord_no: str
    ticker: str
    qty: int = 0  # 0이면 잔량 전부 취고 로직 적용 가능

@router.get("/balance")
async def get_my_balance():
    """마이페이지용 실시간 계좌 및 보유 종목 조회 API"""
    # 내부적으로 KiwoomService가 토큰과 계좌번호를 관리하므로 별도 입력 불필요
    return await kiwoom_service.get_account_balance()

@router.post("/order")
async def execute_manual_order(order_data: OrderRequest):
    """수동 주문 실행 API (잔고 검증 포함)"""
   
    # 1. 매수일 때만 잔고 체크 (매도는 주식 수량을 체크해야 함)
    if order_data.is_buy:
        balance = await kiwoom_service.get_account_balance()
        available_cash = balance["summary"]["available_cash"]
        
        # 주문 총액 계산: $$Total = Qty \times Price$$
        total_order_amount = order_data.qty * order_data.price
        
        if total_order_amount> available_cash:
            raise HTTPException(
                status_code=400, 
                detail=f"잔액이 부족합니다. (필요: {total_order_amount}원 / 잔액: {available_cash}원"
            )

    # 3. 키움 API를 통한 실제 주문 전송
    result = await kiwoom_service.post_trade(
        ticker=order_data.ticker,   # order_data.type에 따른 매수/매도 구분
        qty=order_data.qty,
        price=order_data.price,
        is_buy=order_data.is_buy
    )
    
    if result.get("return_code") != 0 and result.get("return_code") != "0000":
        return {
            "status": "error",
            "message": result.get("return_msg", "주문 처리 중 오류가 발생했습니다."),
            "kiwoom_response": result
        }
        
    return {
    "status": "success",
    "message": f"{order_data.ticker} {order_data.qty}주 주문 전송 완료",
    "kiwoom_response": result
}

@router.post("/order/amend")
async def amend_order(amend_data: AmendRequest):
    """주식 정정 주문 (kt10002)"""
    # 키움 API를 통한 정정 주문 전송
    result = await kiwoom_service.amend_order(
        orig_ord_no=amend_data.orig_ord_no,
        ticker=amend_data.ticker,
        qty=amend_data.qty,
        price=amend_data.price
    )
    
    return_code = str(result.get("return_code", ""))

    if return_code not in ["0", "0000"]:
        return {
            "status": "error",
            "message": result.get("return_msg", "정정 주문 처리 중 오류가 발생했습니다."),
            "kiwoom_response": result
        }

    return {
        "status": "success",
        "message": f"주문번호 {amend_data.orig_ord_no}의 정정 주문이 접수되었습니다.",
        "kiwoom_response": result
    }

@router.post("/order/cancel")
async def cancel_order(cancel_data: CancelRequest):
    """주식 취소 주문 (kt10003)"""
    # 키움 API를 통한 취소 주문 전송
    result = await kiwoom_service.cancel_order(
        orig_ord_no=cancel_data.orig_ord_no,
        ticker=cancel_data.ticker,
        qty=cancel_data.qty
    )
    
    # 1. 키움 리턴 코드 확인
    return_code = str(result.get("return_code", ""))

    # 2. 성공 코드가 아닌 경우 status를 error로 변경    
    if return_code not in ["0", "0000"]:
        return {
            "status": "error",
            "message": result.get("return_msg", "취소 주문 중 오류가 발생했습니다."),
            "kiwoom_response": result
        }

    return {
        "status": "success",
        "message": f"주문번호 {cancel_data.orig_ord_no}의 취소 주문이 정상 접수되었습니다.",
        "kiwoom_response": result
    }

@router.get("/order-history")
async def get_order_history(
    qry_tp: str = Query("3", description="1:주문순, 2:역순, 3:미체결, 4:체결내역만"), # 기본값 미체결
    ticker: Optional[str] = Query(None, description="특정 종목 조회 시 종목코드")
):
    try:
        # 서비스 함수 호출
        orders = await kiwoom_service.get_order_history(
            qry_tp=qry_tp, 
            stk_cd=ticker if ticker else ""
        )
        return {
            "status": "success",
            "count": len(orders),
            "data": orders
        }
    except Exception as e:
        # 에러 발생 시 상세 메시지 반환
        raise HTTPException(status_code=500, detail=f"주문 내역 조회 실패: {str(e)}")