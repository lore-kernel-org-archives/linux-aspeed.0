From: Lei Yu <yulei.sh@bytedance.com>
Date: Wed, 21 Jun 2023 20:02:14 +0800
Subject: [PATCH] usb: gadget: aspeed: fix buffer overflow
In-Reply-To: <CAGm54UHWhRQsvaBQM7mgfP2A5os=mYDTfKS9qfS0C5_9XkcrSA@mail.gmail.com>
References: <20221024094853.2877441-1-yulei.sh@bytedance.com>
 <HK0PR06MB32022348EA65805C7109B7D080329@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <CAGm54UExHOBw61DJNqxvW67OSr60fQ+Q247t63RzymiMOmHmFg@mail.gmail.com>
 <HK0PR06MB320203EF8E3AD14C34359B0580329@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <Y1ueEYJk2epT/g4J@kroah.com> <HK0PR06MB32024F58191E17DC5ABC99F380329@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <Y1uyssu84kl1INSR@kroah.com> <CAGm54UGmp=kTKGLhEfENF4SqkvRt_GcpuGH_g5PjtQiBkwtOsA@mail.gmail.com>
 <TY2PR06MB321303972156248AB08CAB2480EB9@TY2PR06MB3213.apcprd06.prod.outlook.com>
 <CAGm54UHWhRQsvaBQM7mgfP2A5os=mYDTfKS9qfS0C5_9XkcrSA@mail.gmail.com>
Message-ID: <CAGm54UG2uD2jruRc33Xm4izepYpuFNBBcGe594as8_fx1uEWQg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Dec 21, 2022 at 10:26?AM Lei Yu <yulei.sh@bytedance.com> wrote:
>
> On Wed, Dec 21, 2022 at 10:17 AM Neal Liu <neal_liu@aspeedtech.com> wrote:
> > > > > > > Using rndis is able to set MTU to 2000, and the issue can be
> > > reproduced.
> > >
> > > USB ecm is also tested and it is possible to set MTU to 2000, and could
> > > reproduce the issue.
> > > So I think this patch is needed anyway.
> > >
> > > @Neal Liu Could you kindly help to verify the USB ECM case?
> >
> > How to set MTU to 2000 on USB ECM case? I remember last time I cannot set by using "ifconfig ..."
> > Regardless ECM or RNDIS, I agree this patch is still needed.
>
> You were able to set MTU to 2000 for RNDIS but not for NCM.
> @Greg Kroah-Hartman indicated that RNDIS should not be used anymore.
> So I tested ECM and verified it could set MTU 2000 and the issue could
> be reproduced.

This patch fixes the kernel oops in the aspeed-vhub driver for both
USB ECM and RNDIS.
It now has an Acked-by from benh and Reviewed-by from neal_liu

Should we merge this patch?
