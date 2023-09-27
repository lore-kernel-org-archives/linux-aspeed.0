From: Joel Stanley <joel@jms.id.au>
Date: Wed, 27 Sep 2023 02:25:56 +0000
Subject: [PATCH 00/40] soc: Convert to platform remove callback returning void
In-Reply-To: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
Message-ID: <CACPK8XeROYz_XaB3TvUhdXm7Vm8fjC8yU+mfvA58=_FiDrBy-g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 25 Sept 2023 at 09:55, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> this series converts all platform drivers below drivers/soc to use
> .remove_new(). The motivation is to get rid of an integer return code
> that is (mostly) ignored by the platform driver core and error prone on
> the driver side.
>
> See commit 5c5a7680e67b ("platform: Provide a remove callback that
> returns no value") for an extended explanation and the eventual goal.
>
> As there is no single maintainer team for drivers/soc, I suggest the
> individual maintainers to pick up "their" patches.

I'd be happy if Arnd merged the lot at once. Arnd, what do you think?

If that will be too messy then I understand. I have queued the aspeed
ones locally and will push that out if we decide that's the best way
to go.

Thanks for doing this cleanup Uwe.

Cheers,

Joel
