From: Neal Liu <neal_liu@aspeedtech.com>
Date: Thu, 27 Jan 2022 02:11:09 +0000
Subject: [PATCH] usb: gadget: mass_storage: add READ_TOC cmd mask check
In-Reply-To: <YfEnnWuL1cC6airb@kroah.com>
References: <20220126100856.3680716-1-neal_liu@aspeedtech.com>
 <YfEnnWuL1cC6airb@kroah.com>
Message-ID: <HK0PR06MB3202A4690440C2123A2D76D880219@HK0PR06MB3202.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Wednesday, January 26, 2022 6:51 PM
> To: Neal Liu <neal_liu@aspeedtech.com>
> Cc: Felipe Balbi <balbi@kernel.org>; Alan Stern <stern@rowland.harvard.edu>;
> Chen Lin <chen.lin5@zte.com.cn>; Wesley Cheng
> <quic_wcheng@quicinc.com>; Nikita Yushchenko
> <nikita.yoush@cogentembedded.com>; Cai Huoqing <caihuoqing@baidu.com>;
> linux-usb at vger.kernel.org; linux-kernel at vger.kernel.org;
> linux-aspeed at lists.ozlabs.org; BMC-SW <BMC-SW@aspeedtech.com>
> Subject: Re: [PATCH] usb: gadget: mass_storage: add READ_TOC cmd mask
> check
> 
> On Wed, Jan 26, 2022 at 06:08:56PM +0800, Neal Liu wrote:
> > READ_TOC cmnd[2] specifies Format Field which is defined in SCSI-3
> > spec. Add command mask to avoid marking this sense data as invalid.
> >
> > Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> > ---
> >  drivers/usb/gadget/function/f_mass_storage.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/gadget/function/f_mass_storage.c
> > b/drivers/usb/gadget/function/f_mass_storage.c
> > index 46dd11dcb3a8..14d51695b8ae 100644
> > --- a/drivers/usb/gadget/function/f_mass_storage.c
> > +++ b/drivers/usb/gadget/function/f_mass_storage.c
> > @@ -1944,7 +1944,7 @@ static int do_scsi_command(struct fsg_common
> *common)
> >  		common->data_size_from_cmnd =
> >  			get_unaligned_be16(&common->cmnd[7]);
> >  		reply = check_command(common, 10, DATA_DIR_TO_HOST,
> > -				      (7<<6) | (1<<1), 1,
> > +				      (7<<6) | (1<<1) | (1<<2), 1,
> 
> Can we have real names here instead of magic numbers?
> 
> And what commit does this fix?  Is it a regression or has it always never
> worked properly?
> 
> thanks,
> 
> greg k-h

This patch fix Windows Server OS installation failure problem.
Since @Roger already sent similar patch fixed, I'll try it.
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/?h=usb-testing&id=89ada0fe669a7abf8777b793b874202a0767a24f
Thanks

-Neal
