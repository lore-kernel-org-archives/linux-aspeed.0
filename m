From: Joel Stanley <joel@jms.id.au>
Date: Mon, 14 Sep 2020 12:25:41 +0000
Subject: [PATCH] MAINTAINERS: make linux-aspeed list remarks consistent
In-Reply-To: <alpine.DEB.2.21.2009131156090.6163@felia>
References: <20200912183334.22683-1-lukas.bulwahn@gmail.com>
 <alpine.DEB.2.21.2009131156090.6163@felia>
Message-ID: <CACPK8XdvmUN6XsqGEYMwyb1JhWtm9Nyrje8xXx2zBN4N=+gNow@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, 13 Sep 2020 at 09:57, Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
>
>
> On Sat, 12 Sep 2020, Lukas Bulwahn wrote:
>
> > Commit f15a3ea80391 ("MAINTAINERS: Add ASPEED BMC GFX DRM driver entry")
> > does not mention that linux-aspeed at lists.ozlabs.org is moderated for
> > non-subscribers, but the other three entries for
> > linux-aspeed at lists.ozlabs.org do.
> >
> > By 'majority vote' among entries, let us assume it was just missed here and
> > adjust it to be consistent with others.
> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> > applies cleanly on master and next-20200911
> >
> > Joel, please ack.
> > David, Daniel, please pick this minor non-urgent clean-up patch.
> >
> > This patch submission will also show me if linux-aspeed is moderated or
> > not. I have not subscribed to linux-aspeed and if it shows up quickly in
> > the archive, the list is probably not moderated; and if it takes longer,
> > it is moderated, and hence, validating the patch.
> >
>
> I did quickly get back an moderation email that my email is being held
> back. So, that response validates my patch.

The bmc related lists (openbmc@, linux-aspeed@, linux-fsi@) on
ozlabs.org that I own have a soft-moderation policy. The first time
you post a patch I add you to a whitelist. Given the low volume on
these lists this works for me.

I don't know if this necessitates marking the lists as moderated in
MAINTINERS, but if you find that helpful then that's fine with me.

Acked-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel
