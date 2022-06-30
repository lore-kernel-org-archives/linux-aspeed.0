From: Sebin Sebastian <mailmesebin00@gmail.com>
Date: Thu, 30 Jun 2022 03:52:02 -0000
Subject: [PATCH -next] usb: gadget: dereference before null check
In-Reply-To: <Yrxwbb/TbFmYdga/@kroah.com>
References: <20220629080726.107297-1-mailmesebin00@gmail.com>
 <YrwMJ+3mdFO2Lpm0@kroah.com>
 <YrxCP4EE2jhUm8e+@sebin-inspiron>
 <Yrxwbb/TbFmYdga/@kroah.com>
Message-ID: <Yr0d1tULzx4Mn1pp@sebin-inspiron>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jun 29, 2022 at 05:31:57PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jun 29, 2022 at 05:44:55PM +0530, Sebin Sebastian wrote:
> > On Wed, Jun 29, 2022 at 10:24:07AM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, Jun 29, 2022 at 01:37:25PM +0530, SebinSebastian wrote:
> > > > Fix coverity warning dereferencing before null check. _ep and desc is
> > > > dereferenced on all paths until the check for null. Move the
> > > > initializations after the check for null.
> > > > Coverity issue: 1518209
> > > > 
> > > > Signed-off-by: SebinSebastian <mailmesebin00@gmail.com>
> > > > ---
> > > >  drivers/usb/gadget/udc/aspeed_udc.c | 9 +++++----
> > > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
> > > > index d75a4e070bf7..96f8193fca15 100644
> > > > --- a/drivers/usb/gadget/udc/aspeed_udc.c
> > > > +++ b/drivers/usb/gadget/udc/aspeed_udc.c
> > > > @@ -341,10 +341,6 @@ static void ast_udc_stop_activity(struct ast_udc_dev *udc)
> > > >  static int ast_udc_ep_enable(struct usb_ep *_ep,
> > > >  			     const struct usb_endpoint_descriptor *desc)
> > > >  {
> > > > -	u16 maxpacket = usb_endpoint_maxp(desc);
> > > > -	struct ast_udc_ep *ep = to_ast_ep(_ep);
> > > > -	struct ast_udc_dev *udc = ep->udc;
> > > > -	u8 epnum = usb_endpoint_num(desc);
> > > >  	unsigned long flags;
> > > >  	u32 ep_conf = 0;
> > > >  	u8 dir_in;
> > > > @@ -356,6 +352,11 @@ static int ast_udc_ep_enable(struct usb_ep *_ep,
> > > >  		return -EINVAL;
> > > >  	}
> > > > 
> > > > +	u16 maxpacket = usb_endpoint_maxp(desc);
> > > > +	struct ast_udc_ep *ep = to_ast_ep(_ep);
> > > > +	struct ast_udc_dev *udc = ep->udc;
> > > > +	u8 epnum = usb_endpoint_num(desc);
> > > > +
> > > >  	if (!udc->driver) {
> > > >  		EP_DBG(ep, "bogus device state\n");
> > > >  		return -ESHUTDOWN;
> > > > --
> > > > 2.34.1
> > > > 
> > > 
> > > Hi,
> > > 
> > > This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> > > a patch that has triggered this response.  He used to manually respond
> > > to these common problems, but in order to save his sanity (he kept
> > > writing the same thing over and over, yet to different people), I was
> > > created.  Hopefully you will not take offence and will fix the problem
> > > in your patch and resubmit it so that it can be accepted into the Linux
> > > kernel tree.
> > > 
> > > You are receiving this message because of the following common error(s)
> > > as indicated below:
> > > 
> > > - Your patch breaks the build.
> > > 
> > > - Your patch contains warnings and/or errors noticed by the
> > >   scripts/checkpatch.pl tool.
> > > 
> > > - This looks like a new version of a previously submitted patch, but you
> > >   did not list below the --- line any changes from the previous version.
> > >   Please read the section entitled "The canonical patch format" in the
> > >   kernel file, Documentation/SubmittingPatches for what needs to be done
> > >   here to properly describe this.
> > > 
> > > If you wish to discuss this problem further, or you have questions about
> > > how to resolve this issue, please feel free to respond to this email and
> > > Greg will reply once he has dug out from the pending patches received
> > > from other developers.
> > > 
> > > thanks,
> > > 
> > > greg k-h's patch email bot
> > 
> > I am sorry to keep on bothering with this incorrect patches. I am
> > running the checkpatch script everytime before I sent any patches. It is
> > not showing any warnings or errors. Is it because of my name that my
> > patches are getting rejected? I can see a space missing.
> 
> Did you test build your patch?  If not, why not?
> 
> thanks,
> 
> greg k-h

Ok, now I understand the source of all errors. I did build the entire
tree, but make never touched udc. I have fixed all errors and warnings,
build the patch properly, ran through checkpatch and is now ready for
submission.
