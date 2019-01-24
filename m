From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 24 Jan 2019 09:15:44 +0100
Subject: [PATCH] misc: aspeed-lpc-ctrl: Correct return values
In-Reply-To: <20190123230634.1815021-1-vijaykhemka@fb.com>
References: <20190123230634.1815021-1-vijaykhemka@fb.com>
Message-ID: <20190124081544.GA1649@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jan 23, 2019 at 03:06:34PM -0800, Vijay Khemka wrote:
> Corrected some of return values with appropriate meanings.
> 
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> ---
>  drivers/misc/aspeed-lpc-ctrl.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/misc/aspeed-lpc-ctrl.c b/drivers/misc/aspeed-lpc-ctrl.c
> index 332210e06e98..97ae341109d5 100644
> --- a/drivers/misc/aspeed-lpc-ctrl.c
> +++ b/drivers/misc/aspeed-lpc-ctrl.c
> @@ -68,7 +68,6 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, unsigned int cmd,
>  		unsigned long param)
>  {
>  	struct aspeed_lpc_ctrl *lpc_ctrl = file_aspeed_lpc_ctrl(file);
> -	struct device *dev = file->private_data;
>  	void __user *p = (void __user *)param;
>  	struct aspeed_lpc_ctrl_mapping map;
>  	u32 addr;
> @@ -93,8 +92,8 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, unsigned int cmd,
>  
>  		/* If memory-region is not described in device tree */
>  		if (!lpc_ctrl->mem_size) {
> -			dev_err(dev, "Didn't find reserved memory\n");
> -			return -EINVAL;
> +			pr_err("aspeed_lpc_ctrl: ioctl: Didn't find reserved memory\n");

Why did you change from dev_err() to pr_err()?  You just lost a lot of
information that the user previously was getting from dev_err() :(



> +			return -ENXIO;
>  		}
>  
>  		map.size = lpc_ctrl->mem_size;
> @@ -134,16 +133,16 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, unsigned int cmd,
>  
>  		if (map.window_type == ASPEED_LPC_CTRL_WINDOW_FLASH) {
>  			if (!lpc_ctrl->pnor_size) {
> -				dev_err(dev, "Didn't find host pnor flash\n");
> -				return -EINVAL;
> +				pr_err("aspeed_lpc_ctrl: ioctl: Didn't find host pnor flash\n");

Again, don't do that :(

thanks,

greg k-h
