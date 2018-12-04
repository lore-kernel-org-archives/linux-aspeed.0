From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Tue, 4 Dec 2018 12:41:38 -0600
Subject: [PATCH] clk: aspeed: Mark lclk (LPC) and espiclk (eSPI) as
 critical
In-Reply-To: <154394694584.88331.12700815292714558990@swboyd.mtv.corp.google.com>
References: <20181204172357.23665-1-jae.hyun.yoo@linux.intel.com>
 <154394694584.88331.12700815292714558990@swboyd.mtv.corp.google.com>
Message-ID: <823c0ad5-a03c-86ea-f089-556420e9878a@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 12/4/2018 12:09 PM, Stephen Boyd wrote:
> Quoting Jae Hyun Yoo (2018-12-04 09:23:57)
>> diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
>> index 596136793fc4..01633ad85683 100644
>> --- a/drivers/clk/clk-aspeed.c
>> +++ b/drivers/clk/clk-aspeed.c
>> @@ -95,7 +95,7 @@ static const struct aspeed_gate_data aspeed_gates[] = {
>>          [ASPEED_CLK_GATE_DCLK] =        {  5, -1, "dclk-gate",          NULL,   CLK_IS_CRITICAL }, /* DAC */
>>          [ASPEED_CLK_GATE_REFCLK] =      {  6, -1, "refclk-gate",        "clkin", CLK_IS_CRITICAL },
>>          [ASPEED_CLK_GATE_USBPORT2CLK] = {  7,  3, "usb-port2-gate",     NULL,   0 }, /* USB2.0 Host port 2 */
>> -       [ASPEED_CLK_GATE_LCLK] =        {  8,  5, "lclk-gate",          NULL,   0 }, /* LPC */
>> +       [ASPEED_CLK_GATE_LCLK] =        {  8,  5, "lclk-gate",          NULL,   CLK_IS_CRITICAL }, /* LPC */
>>          [ASPEED_CLK_GATE_USBUHCICLK] =  {  9, 15, "usb-uhci-gate",      NULL,   0 }, /* USB1.1 (requires port 2 enabled) */
>>          [ASPEED_CLK_GATE_D1CLK] =       { 10, 13, "d1clk-gate",         NULL,   0 }, /* GFX CRT */
>>          [ASPEED_CLK_GATE_YCLK] =        { 13,  4, "yclk-gate",          NULL,   0 }, /* HAC */
>> @@ -103,7 +103,7 @@ static const struct aspeed_gate_data aspeed_gates[] = {
>>          [ASPEED_CLK_GATE_UART1CLK] =    { 15, -1, "uart1clk-gate",      "uart", 0 }, /* UART1 */
>>          [ASPEED_CLK_GATE_UART2CLK] =    { 16, -1, "uart2clk-gate",      "uart", 0 }, /* UART2 */
>>          [ASPEED_CLK_GATE_UART5CLK] =    { 17, -1, "uart5clk-gate",      "uart", 0 }, /* UART5 */
>> -       [ASPEED_CLK_GATE_ESPICLK] =     { 19, -1, "espiclk-gate",       NULL,   0 }, /* eSPI */
>> +       [ASPEED_CLK_GATE_ESPICLK] =     { 19, -1, "espiclk-gate",       NULL,   CLK_IS_CRITICAL }, /* eSPI */
> 
> Can you please add a comment in the code as well so that we can easily
> recall why such clks are marked critical a year from now without having
> to do git archaeology.
> 

Okay, I'll add a comment.

Thanks,
Jae
