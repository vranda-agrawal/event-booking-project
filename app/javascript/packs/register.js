const appId = "sandbox-sq0idb-vTcIBh8Nn9wxcjrZ8nUYcw";
const locationId = "L529VGVNRVPCX";
async function initializeCard(payments) {
  const card = await payments.card();
  await card.attach('#card-container');
  return card;
}

async function tokenize(paymentMethod) 
  {
    const tokenResult = await paymentMethod.tokenize();   
    if (tokenResult.status === 'OK') 
    {
      return tokenResult.token;
    } 
    else 
    {
      let errorMessage = `Tokenization failed with status: ${tokenResult.status}`;
      if (tokenResult.errors) {
        errorMessage += ` and errors: ${JSON.stringify(
          tokenResult.errors
        )}`;
      }
    return errorMessage
    }
  }

  document.addEventListener('DOMContentLoaded', async function () {
  const cardButton = document.getElementById('card-button');
  cardButton.addEventListener('click', async function (event) 
    {
      await handlePaymentMethodSubmission(event, card);
      document.getElementById('payment-form').submit();
    });

  if (!window.Square) {
    return;
  }
  
  let payments;
  try {
    payments = window.Square.payments(appId, locationId);
  } catch(e) {
    const statusContainer = document.getElementById(
      'payment-status-container'
    );
    statusContainer.className = 'missing-credentials';
    statusContainer.style.visibility = 'visible';
  	console.error(e);	
    return;
  }

  let card;
  try {
    card = await initializeCard(payments);
  } catch (e) {
    console.error('Initializing Card failed', e);
    return;
  }

  cardButton.addEventListener('click', async function (event) {
    handlePaymentMethodSubmission(event, card);
  });

  async function handlePaymentMethodSubmission(event, paymentMethod) {
    event.preventDefault();
  
    try {
        cardButton.disabled = true;
        const token = await tokenize(paymentMethod);
        debugger;
      	document.getElementById('card-nonce').value = token;
    } catch (e) {
	  console.error(e.message);
      cardButton.disabled = false;
    }
  }
});
