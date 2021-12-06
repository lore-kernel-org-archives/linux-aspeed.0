From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 06 Dec 2021 11:08:42 +1100
Subject: [PATCH 2/3] usb: aspeed-vhub: support remote wakeup feature
In-Reply-To: <HK0PR06MB3202F55EEE02B9931D9CD4AD80699@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20211126110954.2677627-1-neal_liu@aspeedtech.com>
 <20211126110954.2677627-3-neal_liu@aspeedtech.com>
 <279c42970790787e928ed017149e300835085235.camel@kernel.crashing.org>
 <HK0PR06MB3202A1F0710655B3E8EA709580679@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <5d234a400a89f64ad183020b93b68f478f1addc7.camel@kernel.crashing.org>
 <HK0PR06MB3202F55EEE02B9931D9CD4AD80699@HK0PR06MB3202.apcprd06.prod.outlook.com>
Message-ID: <07472b315d6adecb874f29128e9b5fe3eadad590.camel@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2021-12-02 at 03:03 +0000, Neal Liu wrote:
> > 
> Let's me describe more details for our hardware behavior and hope you
> understand.
> 
> HUB00[3]: MANUAL_REMOTE_WAKEUP
> HUB00[4]: AUTO_REMOTE_WAKEUP
> 
> Set HUB00[3] implies USB device will do remote wakeup if any write
> command to vhub register.
> Set HUB00[4] implies USB device will do remote wakeup. It can only be
> set in suspend state.
> 
> For current design, d->wakeup_en only controls whether HUB00[4] can
> be set through usb_gadget_ops.wakeup().
> If some applications (take KVM as example) want to wakeup host by
> sending a packet, it won't go through sb_gadget_ops.wakeup().
> We enable HUB00[3] to fix this problem. It won't override above
> mentioned behavior.
> If host has enabled the USB_DEVICE_REMOTE_WAKEUP feature, it has 2
> ways to wakeup host.
> 1. set srp 1 (/sys/device/platform/xxxxxxxxx/udc/xxxxxx/srp)
> 2. emulated device has activity
> If host has disabled the USB_DEVICE_REMOTE_WAKEUP feature, these 2
> ways still cannot wakeup host even if USB bus is in resume state.
> Thanks

So what you are saying is that currently, the various gadgets aren't
calling usb_gadget_wakeup() ?

Ie. it should be a gadget policy to decide when to wake-up I suppose,
but it's true that nothing in the core nor the existing gadgets seem to
handle that.

I think what you propose is a band-aid. The real problem is that the
gadget drivers should trigger wakeups (or the core should do so on
activity).

That said, for now, I don't object to adding that "auto" bit, but I
would prefer if that behaviour was use configurable.

Cheers,
Ben.

