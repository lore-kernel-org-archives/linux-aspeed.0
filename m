From: Alan Stern <stern@rowland.harvard.edu>
Date: Wed, 26 Jan 2022 11:00:44 -0500
Subject: [PATCH] usb: gadget: mass_storage: add READ_TOC cmd mask check
In-Reply-To: <20220126100856.3680716-1-neal_liu@aspeedtech.com>
References: <20220126100856.3680716-1-neal_liu@aspeedtech.com>
Message-ID: <YfFwLDLX5D4dYLTb@rowland.harvard.edu>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jan 26, 2022 at 06:08:56PM +0800, Neal Liu wrote:
> READ_TOC cmnd[2] specifies Format Field which is defined
> in SCSI-3 spec. Add command mask to avoid marking this
> sense data as invalid.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> ---
>  drivers/usb/gadget/function/f_mass_storage.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
> index 46dd11dcb3a8..14d51695b8ae 100644
> --- a/drivers/usb/gadget/function/f_mass_storage.c
> +++ b/drivers/usb/gadget/function/f_mass_storage.c
> @@ -1944,7 +1944,7 @@ static int do_scsi_command(struct fsg_common *common)
>  		common->data_size_from_cmnd =
>  			get_unaligned_be16(&common->cmnd[7]);
>  		reply = check_command(common, 10, DATA_DIR_TO_HOST,
> -				      (7<<6) | (1<<1), 1,
> +				      (7<<6) | (1<<1) | (1<<2), 1,
>  				      "READ TOC");
>  		if (reply == 0)
>  			reply = do_read_toc(common, bh);

You've been anticipated:

https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/?h=usb-testing&id=89ada0fe669a7abf8777b793b874202a0767a24f

Alan Stern
