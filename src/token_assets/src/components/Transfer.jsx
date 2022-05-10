import React, { useState } from "react";
import {Principal} from "@dfinity/principal";
import {token} from "../../../declarations/token";


function Transfer() {
  const [recipientId,setId]=useState(null);
  const [amountTransfer,setAmountTransfer]=useState(null);
  const [isDisabled,setIsDisabled]= useState(false);
  const [transferResult,setTransferResult]=useState("Transfer");
  async function handleClick() {
    setIsDisabled(true);
      const recipient = Principal.fromText(recipientId);
      const amountToTransfer= Number(amountTransfer);

      setTransferResult(await token.transfer(recipient,amountToTransfer));
      setTimeout(()=>{
        setTransferResult("Transfer");
        setIsDisabled(false);
      },2000);
  }

  return (
    <div className="window white">
      <div className="transfer">
        <fieldset>
          <legend>To Account:</legend>
          <ul>
            <li>
              <input
                type="text"
                id="transfer-to-id"
                value={recipientId}
                onChange={(e)=>setId(e.target.value)}
              />
            </li>
          </ul>
        </fieldset>
        <fieldset>
          <legend>Amount:</legend>
          <ul>
            <li>
              <input
                type="number"
                id="amount"
                value={amountTransfer}
                onChange={(e)=>setAmountTransfer(e.target.value)}
              />
            </li>
          </ul>
        </fieldset>
        <p className="trade-buttons">
          <button id="btn-transfer" disabled={isDisabled}onClick={handleClick} >
            {transferResult}
          </button>
        </p>
      </div>
    </div>
  );
}

export default Transfer;
