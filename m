From: Klaus Jensen <its@irrelevant.dk>
Date: Fri, 3 Jun 2022 07:49:02 +0200
Subject: [PATCH] i2c: aspeed: do not mask SLAVE_MATCH
In-Reply-To: <20220602054842.122271-1-its@irrelevant.dk>
References: <20220602054842.122271-1-its@irrelevant.dk>
Message-ID: <YpmgzroKbMO3TIsY@apples>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Jun  2 07:48, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> When commit f9eb91350bb2 ("i2c: aspeed: added slave support for Aspeed
> I2C driver") added slave mode support, the SLAVE_MATCH interrupt bit
> (bit 7) was not added to INTR_ALL and so will never be set by the Aspeed
> I2C controller.
> 
> Fixes: f9eb91350bb2 ("i2c: aspeed: added slave support for Aspeed I2C driver")
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
> I am working on slave mode in QEMU and noticed that the device would not
> generate the SLAVE_ADDR_RX_MATCH interrupt. This patch fixes it, but I
> do not have a spec sheet on the Aspeed, so I am not sure if this is the
> intended behavior?
> 
>  drivers/i2c/busses/i2c-aspeed.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> index 771e53d3d197..7f432babcd72 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -86,6 +86,7 @@
>  #define ASPEED_I2CD_INTR_ALL						       \
>  		(ASPEED_I2CD_INTR_SDA_DL_TIMEOUT |			       \
>  		 ASPEED_I2CD_INTR_BUS_RECOVER_DONE |			       \
> +		 ASPEED_I2CD_INTR_SLAVE_MATCH |				       \
>  		 ASPEED_I2CD_INTR_SCL_TIMEOUT |				       \
>  		 ASPEED_I2CD_INTR_ABNORMAL |				       \
>  		 ASPEED_I2CD_INTR_NORMAL_STOP |				       \
> -- 
> 2.36.1
> 

I've been informed that SLAVE_MATCH should always be generated,
regardless of INTR_CTRL, so please ignore this patch.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20220603/181eab89/attachment-0001.sig>
