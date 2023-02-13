From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 13 Feb 2023 09:31:30 +0100
Subject: [PATCH 2/4] soc: aspeed: Add UART DMA support
In-Reply-To: <KL1PR0601MB37818F70A166356FED0FEC9C91DD9@KL1PR0601MB3781.apcprd06.prod.outlook.com>
References: <20230210072643.2772-1-chiawei_wang@aspeedtech.com>
 <20230210072643.2772-3-chiawei_wang@aspeedtech.com>
 <c1e096fa-5941-cdd8-2cdc-ecf04661a389@linaro.org>
 <KL1PR0601MB37818F70A166356FED0FEC9C91DD9@KL1PR0601MB3781.apcprd06.prod.outlook.com>
Message-ID: <ad200b06-368a-1f01-41e1-6b639d128186@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 13/02/2023 02:50, ChiaWei Wang wrote:
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Friday, February 10, 2023 5:14 PM
>>
>> On 10/02/2023 08:26, Chia-Wei Wang wrote:
>>> This driver provides DMA support for AST26xx UART and VUART devices.
>>> It is useful to offload CPU overhead while using UART/VUART for binary
>>> file transfer.
>>>
>>> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
>>> ---
>>>  drivers/soc/aspeed/Kconfig             |   9 +
>>>  drivers/soc/aspeed/Makefile            |   1 +
>>>  drivers/soc/aspeed/aspeed-udma.c       | 447
>> +++++++++++++++++++++++++
>>>  include/linux/soc/aspeed/aspeed-udma.h |  34 ++
>>
>> NAK.
>>
>> DMA drivers do not go to soc, but to dma subsystem.
> 
> The UDMA is dedicated only to UART use and is not fully fit to the DMAEngine subsystem.
> For example, the suspend/resume operations of common DMA engine are not supported.
> After observing certain existing DMA implementation in other soc folders, we put UDMA in the soc/aspeed as well.
> If it is not appropriate, should we integrate UDMA into the UART driver or try to make UDMA DMAEngine based?


You did not Cc dma folks, so how would I know... Maybe soc is right
place if the DMA driver is not suitable for other consumers than UART.
Maybe not.

Best regards,
Krzysztof

