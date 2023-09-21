From: Simon Horman <horms@kernel.org>
Date: Thu, 21 Sep 2023 16:04:32 +0100
Subject: [PATCH net-next 00/19] net: mdio: Convert to platform remove
 callback returning void
In-Reply-To: <20230918195102.1302746-1-u.kleine-koenig@pengutronix.de>
References: <20230918195102.1302746-1-u.kleine-koenig@pengutronix.de>
Message-ID: <20230921150432.GP224399@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Sep 18, 2023 at 09:50:43PM +0200, Uwe Kleine-K?nig wrote:
> Hello,
> 
> this series convert all platform drivers below drivers/net/mdio to
> use remove_new. The motivation is to get rid of an integer return code
> that is (mostly) ignored by the platform driver core and error prone on
> the driver side.
> 
> See commit 5c5a7680e67b ("platform: Provide a remove callback that
> returns no value") for an extended explanation and the eventual goal.
> 
> There are no interdependencies between the patches. As there are still
> quite a few drivers to convert, I'm happy about every patch that makes
> it in. So even if there is a merge conflict with one patch until you
> apply, please apply the remainder of this series anyhow.
> 
> Best regards
> Uwe

For series,

Reviewed-by: Simon Horman <horms@kernel.org>

