From: Joel Stanley <joel@jms.id.au>
Date: Wed, 9 Sep 2020 07:22:19 +0000
Subject: [PATCH] ARM: aspeed: g5: Do not set sirq polarity
In-Reply-To: <1e56af7945b93a22e31ba6d81da82cbdb1b237b6.camel@ozlabs.org>
References: <20200812112400.2406734-1-joel@jms.id.au>
 <1e56af7945b93a22e31ba6d81da82cbdb1b237b6.camel@ozlabs.org>
Message-ID: <CACPK8XfZ6hLv0Ls0g=b5wdr6A3ei3nzVKDgyOt5Su_Y8g8yQ7A@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 27 Aug 2020 at 06:27, Jeremy Kerr <jk@ozlabs.org> wrote:
>
> Hi Joel,
>
> > A feature was added to the aspeed vuart driver to configure the vuart
> > interrupt (sirq) polarity according to the LPC/eSPI strapping register.
> >
> > Systems that depend on a active low behaviour (sirq_polarity set to 0)
> > such as OpenPower boxes also use LPC, so this relationship does not
> > hold.
> >
> > The property was added for a Tyan S7106 system which is not supported
> > in the kernel tree. Should this or other systems wish to use this
> > feature of the driver they should add it to the machine specific device
> > tree.
> >
> > Fixes: c791fc76bc72 ("arm: dts: aspeed: Add vuart aspeed,sirq-polarity-sense...")
> > Cc: stable at vger.kernel.org
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
>
> LGTM. I've tested this on the s2600st, which is strapped for eSPI. All
> good there too, as expected.
>
> Tested-by: Jeremy Kerr <jk@ozlabs.org>
>
> and/or:
>
> Reviewed-by: Jeremy Kerr <jk@ozlabs.org>

Thanks Jeremy. I have queued this for 5.10 and applied it to the openbmc tree.

We should also remove the code from the aspeed-vuart driver, as it is
not correct. Better would be a property that is set according to the
system's hardware design.

Cheers,

Joel
