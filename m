From: Neal Liu <neal_liu@aspeedtech.com>
Date: Thu, 2 Dec 2021 03:03:27 +0000
Subject: [PATCH 2/3] usb: aspeed-vhub: support remote wakeup feature
In-Reply-To: <5d234a400a89f64ad183020b93b68f478f1addc7.camel@kernel.crashing.org>
References: <20211126110954.2677627-1-neal_liu@aspeedtech.com>
 <20211126110954.2677627-3-neal_liu@aspeedtech.com>
 <279c42970790787e928ed017149e300835085235.camel@kernel.crashing.org>
 <HK0PR06MB3202A1F0710655B3E8EA709580679@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <5d234a400a89f64ad183020b93b68f478f1addc7.camel@kernel.crashing.org>
Message-ID: <HK0PR06MB3202F55EEE02B9931D9CD4AD80699@HK0PR06MB3202.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Sent: Wednesday, December 1, 2021 7:38 AM
> To: Neal Liu <neal_liu@aspeedtech.com>; Felipe Balbi <balbi@kernel.org>;
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Joel Stanley
> <joel@jms.id.au>; Andrew Jeffery <andrew@aj.id.au>; Cai Huoqing
> <caihuoqing@baidu.com>; Tao Ren <rentao.bupt@gmail.com>; Julia Lawall
> <julia.lawall@inria.fr>; kernel test robot <lkp@intel.com>; Sasha Levin
> <sashal@kernel.org>; linux-usb at vger.kernel.org; linux-kernel at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; linux-aspeed at lists.ozlabs.org
> Subject: Re: [PATCH 2/3] usb: aspeed-vhub: support remote wakeup feature
> 
> On Tue, 2021-11-30 at 09:47 +0000, Neal Liu wrote:
> > > Should this  be controlled by d->wakeup_en ? IE, we have a feature
> > > for the host to enable/disable remote wakeup, should we honor it ?
> >
> > For KVM usage, remote keyboard packet would be sent if user wants to do
> remote wakeup.
> > In this case, d->wakeup_en is not used.
> > Set VHUB_CTRL_AUTO_REMOTE_WAKEUP to enable HW automatically
> signaling
> > wakeup if any packet would be transferred.
> 
> Sorry, I don't fully understand your explanation here.
> 
> Normally, a USB device will do remote wakeup if it's instructed to do so via the
> appropriate feature being set, which is what wakeup_en reflects. I hadn't
> originally plumbed it in, I forgot why, I think something was either not properly
> documented or not working when I wrote that driver.
> 
> You seem to want to override the behaviour and always send a remote wakeup
> packet no matter what. I am not sure this is desirable for all use cases, and
> might be something we want to make configurable, no ?
> 
> I'm trying to understand your sentence, you seem to imply that the only use
> case here is "KVM" (as in remote USB on a server system) which I can probably
> agree with... mostly.
> 
> And you say in that case, we should always do remote wakeup whenever an
> emulated USB device has any activity (keyboard or otherwise), regardless of
> whether the server has enabled the feature or not.
> 
> Am I correct ? What's the rationale here ?
> 
> Cheers,
> Ben.
> 

Let's me describe more details for our hardware behavior and hope you understand.

HUB00[3]: MANUAL_REMOTE_WAKEUP
HUB00[4]: AUTO_REMOTE_WAKEUP

Set HUB00[3] implies USB device will do remote wakeup if any write command to vhub register.
Set HUB00[4] implies USB device will do remote wakeup. It can only be set in suspend state.

For current design, d->wakeup_en only controls whether HUB00[4] can be set through usb_gadget_ops.wakeup().
If some applications (take KVM as example) want to wakeup host by sending a packet, it won't go through sb_gadget_ops.wakeup().
We enable HUB00[3] to fix this problem. It won't override above mentioned behavior.
If host has enabled the USB_DEVICE_REMOTE_WAKEUP feature, it has 2 ways to wakeup host.
1. set srp 1 (/sys/device/platform/xxxxxxxxx/udc/xxxxxx/srp)
2. emulated device has activity
If host has disabled the USB_DEVICE_REMOTE_WAKEUP feature, these 2 ways still cannot wakeup host even if USB bus is in resume state.
Thanks

-Neal

