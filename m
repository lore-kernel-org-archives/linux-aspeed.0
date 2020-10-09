From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Fri, 9 Oct 2020 06:01:06 +0000
Subject: [PATCH v2 1/3] configs: aspeed: enable UHCI driver in defconfig
In-Reply-To: <CACPK8Xd0h_2yGeyOjrpqV2_X8f4stZA_ur72b4Y4Nx91GrbXag@mail.gmail.com>
References: <20200930040823.26065-4-ryan_chen@aspeedtech.com>
 <20201009024937.11246-1-ryan_chen@aspeedtech.com>
 <20201009024937.11246-2-ryan_chen@aspeedtech.com>
 <20201009044526.GB111063@kroah.com>
 <CACPK8Xd0h_2yGeyOjrpqV2_X8f4stZA_ur72b4Y4Nx91GrbXag@mail.gmail.com>
Message-ID: <HK0PR06MB33809BDA9FD8956CDBE78061F2080@HK0PR06MB3380.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Joel Stanley <joel@jms.id.au>
> Sent: Friday, October 9, 2020 12:55 PM
> To: Greg KH <greg@kroah.com>
> Cc: Ryan Chen <ryan_chen@aspeedtech.com>; Andrew Jeffery
> <andrew@aj.id.au>; Linux ARM <linux-arm-kernel@lists.infradead.org>;
> linux-aspeed <linux-aspeed@lists.ozlabs.org>; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>; linux-usb at vger.kernel.org; BMC-SW
> <BMC-SW@aspeedtech.com>; Alan Stern <stern@rowland.harvard.edu>
> Subject: Re: [PATCH v2 1/3] configs: aspeed: enable UHCI driver in defconfig
> 
> On Fri, 9 Oct 2020 at 04:45, Greg KH <greg@kroah.com> wrote:
> >
> > On Fri, Oct 09, 2020 at 10:49:35AM +0800, Ryan Chen wrote:
> > > v2:
> > >  -Changed : Add SCSI, BLK_DEV_SD, USB_STORAGE support.
> > > v1:
> > >  -Enable UHCI driver in aspeed_g5_defconfig.
> > >
> > > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> >
> > Why do you need this in a defconfig?
> 
> I would prefer configurations that are being used to be present in the defconfig
> so we can test it. I think this is a sensible change.
> 
> Ryan, I gave you my Reviewed-by for the last version of the patch. As you did
> not change the contents of this patch it is fine for you to leave my Reviewed-by
> on it.

Joel, thanks the review, so I need add Reviewed-by at each patch if someone have reviewed the previous patch,
am I right? 
