From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Sun, 28 May 2023 12:37:17 +0100
Subject: [PATCH 00/97] usb: Convert to platform remove callback returning
 void
In-Reply-To: <20230517230239.187727-1-u.kleine-koenig@pengutronix.de>
References: <20230517230239.187727-1-u.kleine-koenig@pengutronix.de>
Message-ID: <2023052848-patronage-zen-de4b@gregkh>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, May 18, 2023 at 01:01:02AM +0200, Uwe Kleine-K?nig wrote:
> Hello,
> 
> this series convers the drivers below drivers/usb to the .remove_new()
> callback of struct platform_driver(). The motivation is to make the
> remove callback less prone for errors and wrong assumptions. See commit
> 5c5a7680e67b ("platform: Provide a remove callback that returns no
> value") for a more detailed rationale.
> 
> All drivers converted here already returned zero unconditionally in their
> .remove() callback, so converting them to .remove_new() is trivial.

All but 2 patches applied, as one was for a driver that wasn't in the
tree anymore, and the dwc2 patch didn't apply at all.

thanks,

greg k-h
