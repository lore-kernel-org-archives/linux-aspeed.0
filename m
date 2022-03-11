From: Wolfram Sang <wsa@kernel.org>
Date: Fri, 11 Mar 2022 07:58:46 +0100
Subject: [PATCH v6 3/4] ipmi: ssif_bmc: Return -EFAULT if
 copy_from_user() fails
In-Reply-To: <20220310114119.13736-4-quan@os.amperecomputing.com>
References: <20220310114119.13736-1-quan@os.amperecomputing.com>
 <20220310114119.13736-4-quan@os.amperecomputing.com>
Message-ID: <YirzJj/BBUQTbKS3@ninjato>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Mar 10, 2022 at 06:41:18PM +0700, Quan Nguyen wrote:
> From: Dan Carpenter <dan.carpenter@oracle.com>
> 
> The copy_from_user() function returns the number of bytes remaining to
> be copied but we should return -EFAULT here.
> 
> Fixes: 501c25b59508 ("ipmi: ssif_bmc: Add SSIF BMC driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>

It is nice that you want to keep this patch seperate to give Dan
credits, but I still think it should be merged into patch 1, so the
initial driver is as flawless as it can be. You could give Dan still
credits by mentioning him in the commit message IMO. Dan, would you be
fine with this?

> v6:
>   + New add in v6, thanks Dan for the patch     [Dan]
> 
>  drivers/char/ipmi/ssif_bmc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ssif_bmc.c b/drivers/char/ipmi/ssif_bmc.c
> index 62db97773654..91ac2cae756e 100644
> --- a/drivers/char/ipmi/ssif_bmc.c
> +++ b/drivers/char/ipmi/ssif_bmc.c
> @@ -87,9 +87,8 @@ static ssize_t ssif_bmc_write(struct file *file, const char __user *buf, size_t
>  	if (count > sizeof(struct ssif_msg))
>  		return -EINVAL;
>  
> -	ret = copy_from_user(&msg, buf, count);
> -	if (ret)
> -		return ret;
> +	if (copy_from_user(&msg, buf, count))
> +		return -EFAULT;
>  
>  	if (!msg.len || count < ssif_msg_len(&msg))
>  		return -EINVAL;
> -- 
> 2.35.1
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20220311/0feccee0/attachment.sig>
