From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Fri, 9 Oct 2020 05:59:19 +0000
Subject: [PATCH v2 1/3] configs: aspeed: enable UHCI driver in defconfig
In-Reply-To: <20201009054650.GA117723@kroah.com>
References: <20200930040823.26065-4-ryan_chen@aspeedtech.com>
 <20201009024937.11246-1-ryan_chen@aspeedtech.com>
 <20201009024937.11246-2-ryan_chen@aspeedtech.com>
 <20201009044526.GB111063@kroah.com>
 <CACPK8Xd0h_2yGeyOjrpqV2_X8f4stZA_ur72b4Y4Nx91GrbXag@mail.gmail.com>
 <20201009054650.GA117723@kroah.com>
Message-ID: <HK0PR06MB3380804F3330D4D34E01CC0DF2080@HK0PR06MB3380.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Greg KH <greg@kroah.com>
> Sent: Friday, October 9, 2020 1:47 PM
> To: Joel Stanley <joel@jms.id.au>
> Cc: Ryan Chen <ryan_chen@aspeedtech.com>; Andrew Jeffery
> <andrew@aj.id.au>; Linux ARM <linux-arm-kernel@lists.infradead.org>;
> linux-aspeed <linux-aspeed@lists.ozlabs.org>; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>; linux-usb at vger.kernel.org; BMC-SW
> <BMC-SW@aspeedtech.com>; Alan Stern <stern@rowland.harvard.edu>
> Subject: Re: [PATCH v2 1/3] configs: aspeed: enable UHCI driver in defconfig
> 
> On Fri, Oct 09, 2020 at 04:55:19AM +0000, Joel Stanley wrote:
> > On Fri, 9 Oct 2020 at 04:45, Greg KH <greg@kroah.com> wrote:
> > >
> > > On Fri, Oct 09, 2020 at 10:49:35AM +0800, Ryan Chen wrote:
> > > > v2:
> > > >  -Changed : Add SCSI, BLK_DEV_SD, USB_STORAGE support.
> > > > v1:
> > > >  -Enable UHCI driver in aspeed_g5_defconfig.
> > > >
> > > > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> > >
> > > Why do you need this in a defconfig?
> >
> > I would prefer configurations that are being used to be present in the
> > defconfig so we can test it. I think this is a sensible change.
> 
> Then it needs to be described in the changelog, otherwise we have no idea
> why this is happening :)
> 
Ok, will send new version describe it. 
