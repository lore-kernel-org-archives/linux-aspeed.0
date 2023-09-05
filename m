From: Andi Shyti <andi.shyti@kernel.org>
Date: Wed, 6 Sep 2023 01:19:15 +0200
Subject: [PATCH] i2c: aspeed: Reset the i2c controller when timeout occurs
In-Reply-To: <20230904012505.340455-1-tommy_huang@aspeedtech.com>
References: <20230904012505.340455-1-tommy_huang@aspeedtech.com>
Message-ID: <20230905231915.rv2ysvxa3bshekjq@zenone.zhora.eu>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Tommy,

Thanks for fixing what I asked, I'm going to review here:

Reviewed-by: Andi Shyti <andi.shyti@kernel.org> 

But still there are 3 things I will ask you for your next
patches:

  1. Please add a version to the patch, this is patch version 2,
     so that the title should be "[PATCH v2] i2c...."

     You can have that with git-format-patch:

        git format-patch -v 2 ....

On Mon, Sep 04, 2023 at 09:25:05AM +0800, Tommy Huang wrote:
> Reset the i2c controller when an i2c transfer timeout occurs.
> The remaining interrupts and device should be reset to avoid
> unpredictable controller behavior.
> 
> Fixes: 2e57b7cebb98 ("i2c: aspeed: Add multi-master use case support")
> Cc: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Cc: <stable@vger.kernel.org> # v5.1+
> 
> Signed-off-by: Tommy Huang <tommy_huang@aspeedtech.com>

  2. Don't leave blank lines between tags. But I think Wolfram
     can fix this before pushing.

> ---

  3. After the '---' it comes the freedom of speach section where
     you can write anything. Please add the changelog, something
     like:

       v1 -> v2
        - Fixed comment...
	- Fixed commit log...
	- etc.

     This is important for reviewers in order to understand what
     has changed from patch v1 to patch v2.

Please, before your next patch, read first the
Documentation/process/submitting-patches.rst document.

Thanks,
Andi

>  drivers/i2c/busses/i2c-aspeed.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> index 2e5acfeb76c8..5a416b39b818 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -698,13 +698,16 @@ static int aspeed_i2c_master_xfer(struct i2c_adapter *adap,
>  
>  	if (time_left == 0) {
>  		/*
> -		 * If timed out and bus is still busy in a multi master
> -		 * environment, attempt recovery at here.
> +		 * In a multi-master setup, if a timeout occurs, attempt
> +		 * recovery. But if the bus is idle, we still need to reset the
> +		 * i2c controller to clear the remaining interrupts.
>  		 */
>  		if (bus->multi_master &&
>  		    (readl(bus->base + ASPEED_I2C_CMD_REG) &
>  		     ASPEED_I2CD_BUS_BUSY_STS))
>  			aspeed_i2c_recover_bus(bus);
> +		else
> +			aspeed_i2c_reset(bus);
>  
>  		/*
>  		 * If timed out and the state is still pending, drop the pending
> -- 
> 2.25.1
> 
