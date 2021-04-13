From: Eddie James <eajames@linux.ibm.com>
Date: Tue, 13 Apr 2021 15:08:52 -0500
Subject: [PATCH] fsi: aspeed: Emit fewer barriers in opb operations
In-Reply-To: <20210223041737.171274-1-joel@jms.id.au>
References: <20210223041737.171274-1-joel@jms.id.au>
Message-ID: <bfb940efdba7d308cf5e91874604582cb5173ada.camel@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2021-02-23 at 14:47 +1030, Joel Stanley wrote:
> When setting up a read or write to the OPB memory space, we must
> perform
> five or six AHB writes. The ordering of these up until the trigger
> write
> does not matter, so use writel_relaxed.

Reviewed-by: Eddie James <eajames@linux.ibm.com>

I have also tested this patch on hardware, so

Tested-by: Eddie James <eajames@linux.ibm.com>

> 
> The generated code goes from (Debian GCC 10.2.1-6):
> 
>         mov     r8, r3
>         mcr     15, 0, sl, cr7, cr10, {4}
>         str     sl, [r6, #20]
>         mcr     15, 0, sl, cr7, cr10, {4}
>         str     r3, [r6, #24]
>         mcr     15, 0, sl, cr7, cr10, {4}
>         str     r1, [r6, #28]
>         mcr     15, 0, sl, cr7, cr10, {4}
>         str     r2, [r6, #32]
>         mcr     15, 0, sl, cr7, cr10, {4}
>         mov     r1, #1
>         str     r1, [r6, #64]   ; 0x40
>         mcr     15, 0, sl, cr7, cr10, {4}
>         str     r1, [r6, #4]
> 
> to this:
> 
>         str     r3, [r7, #20]
>         str     r2, [r7, #24]
>         str     r1, [r7, #28]
>         str     r3, [r7, #64]
>         mov     r8, #0
>         mcr     15, 0, r8, cr7, cr10, {4}
>         str     r3, [r7, #4]
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  drivers/fsi/fsi-master-aspeed.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-
> master-aspeed.c
> index 90dbe58ca1ed..09fff86b2bac 100644
> --- a/drivers/fsi/fsi-master-aspeed.c
> +++ b/drivers/fsi/fsi-master-aspeed.c
> @@ -101,11 +101,11 @@ static int __opb_write(struct fsi_master_aspeed
> *aspeed, u32 addr,
>  	u32 reg, status;
>  	int ret;
>  
> -	writel(CMD_WRITE, base + OPB0_RW);
> -	writel(transfer_size, base + OPB0_XFER_SIZE);
> -	writel(addr, base + OPB0_FSI_ADDR);
> -	writel(val, base + OPB0_FSI_DATA_W);
> -	writel(0x1, base + OPB_IRQ_CLEAR);
> +	writel_relaxed(CMD_WRITE, base + OPB0_RW);
> +	writel_relaxed(transfer_size, base + OPB0_XFER_SIZE);
> +	writel_relaxed(addr, base + OPB0_FSI_ADDR);
> +	writel_relaxed(val, base + OPB0_FSI_DATA_W);
> +	writel_relaxed(0x1, base + OPB_IRQ_CLEAR);
>  	writel(0x1, base + OPB_TRIGGER);
>  
>  	ret = readl_poll_timeout(base + OPB_IRQ_STATUS, reg,
> @@ -149,10 +149,10 @@ static int __opb_read(struct fsi_master_aspeed
> *aspeed, uint32_t addr,
>  	u32 result, reg;
>  	int status, ret;
>  
> -	writel(CMD_READ, base + OPB0_RW);
> -	writel(transfer_size, base + OPB0_XFER_SIZE);
> -	writel(addr, base + OPB0_FSI_ADDR);
> -	writel(0x1, base + OPB_IRQ_CLEAR);
> +	writel_relaxed(CMD_READ, base + OPB0_RW);
> +	writel_relaxed(transfer_size, base + OPB0_XFER_SIZE);
> +	writel_relaxed(addr, base + OPB0_FSI_ADDR);
> +	writel_relaxed(0x1, base + OPB_IRQ_CLEAR);
>  	writel(0x1, base + OPB_TRIGGER);
>  
>  	ret = readl_poll_timeout(base + OPB_IRQ_STATUS, reg,

