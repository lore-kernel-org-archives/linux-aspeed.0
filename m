From: Alan Stern <stern@rowland.harvard.edu>
Date: Wed, 7 Oct 2020 10:58:09 -0400
Subject: [PATCH 2/3] usb: host: add uhci compatible support for
 ast2600-uhci
In-Reply-To: <CACPK8Xc2Y1njgtrtjO1bdmkcQR7jDu+oaOBc3R+CWtn+UrEOhQ@mail.gmail.com>
References: <20200930040823.26065-1-ryan_chen@aspeedtech.com>
 <20200930040823.26065-3-ryan_chen@aspeedtech.com>
 <CACPK8Xc2Y1njgtrtjO1bdmkcQR7jDu+oaOBc3R+CWtn+UrEOhQ@mail.gmail.com>
Message-ID: <20201007145809.GA456169@rowland.harvard.edu>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Oct 07, 2020 at 11:25:04AM +0000, Joel Stanley wrote:
> On Wed, 30 Sep 2020 at 04:08, Ryan Chen <ryan_chen@aspeedtech.com> wrote:
> >
> > Add support for AST2600 SOC UHCI driver.
> >
> > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> 
> USB maintainers, can you please take this patch (2/3)? I will take the
> others in this series through the aspeed tree.
> 
> Cheers,
> 
> Joel
> 
> 
> > ---
> >  drivers/usb/host/uhci-platform.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/host/uhci-platform.c b/drivers/usb/host/uhci-platform.c
> > index 70dbd95c3f06..fa40fe125c2a 100644
> > --- a/drivers/usb/host/uhci-platform.c
> > +++ b/drivers/usb/host/uhci-platform.c
> > @@ -113,7 +113,8 @@ static int uhci_hcd_platform_probe(struct platform_device *pdev)
> >                                 num_ports);
> >                 }
> >                 if (of_device_is_compatible(np, "aspeed,ast2400-uhci") ||
> > -                   of_device_is_compatible(np, "aspeed,ast2500-uhci")) {
> > +                       of_device_is_compatible(np, "aspeed,ast2500-uhci") ||
> > +                       of_device_is_compatible(np, "aspeed,ast2600-uhci")) {
> >                         uhci->is_aspeed = 1;
> >                         dev_info(&pdev->dev,
> >                                  "Enabled Aspeed implementation workarounds\n");
> > --
> > 2.17.1
> >

The indentation of the continuation lines isn't good, because the 
continued parts are aligned with the lines in the conditional block.  
They should be visually distinct.  Either align with the "of_device..." 
at the start or indent by two extra tab stops.

Once this is fixed, you can add:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern
