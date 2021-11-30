From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 01 Dec 2021 10:37:50 +1100
Subject: [PATCH 2/3] usb: aspeed-vhub: support remote wakeup feature
In-Reply-To: <HK0PR06MB3202A1F0710655B3E8EA709580679@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20211126110954.2677627-1-neal_liu@aspeedtech.com>
 <20211126110954.2677627-3-neal_liu@aspeedtech.com>
 <279c42970790787e928ed017149e300835085235.camel@kernel.crashing.org>
 <HK0PR06MB3202A1F0710655B3E8EA709580679@HK0PR06MB3202.apcprd06.prod.outlook.com>
Message-ID: <5d234a400a89f64ad183020b93b68f478f1addc7.camel@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2021-11-30 at 09:47 +0000, Neal Liu wrote:
> > Should this  be controlled by d->wakeup_en ? IE, we have a feature for the
> > host to enable/disable remote wakeup, should we honor it ?
> 
> For KVM usage, remote keyboard packet would be sent if user wants to do remote wakeup.
> In this case, d->wakeup_en is not used.
> Set VHUB_CTRL_AUTO_REMOTE_WAKEUP to enable HW automatically signaling wakeup if
> any packet would be transferred.

Sorry, I don't fully understand your explanation here.

Normally, a USB device will do remote wakeup if it's instructed to do
so via the appropriate feature being set, which is what wakeup_en
reflects. I hadn't originally plumbed it in, I forgot why, I think
something was either not properly documented or not working when I
wrote that driver.

You seem to want to override the behaviour and always send a remote
wakeup packet no matter what. I am not sure this is desirable for all
use cases, and might be something we want to make configurable, no ?

I'm trying to understand your sentence, you seem to imply that the only
use case here is "KVM" (as in remote USB on a server system) which I
can probably agree with... mostly.

And you say in that case, we should always do remote wakeup whenever an
emulated USB device has any activity (keyboard or otherwise),
regardless of whether the server has enabled the feature or not.

Am I correct ? What's the rationale here ?

Cheers,
Ben.


