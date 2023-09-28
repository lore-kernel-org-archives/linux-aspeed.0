From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Thu, 28 Sep 2023 08:14:49 +0200
Subject: [PATCH 00/40] soc: Convert to platform remove callback returning
 void
In-Reply-To: <f4hvrslynlgmxu4a2gogc5idvumskhaalxgwildy56yqk2wz7d@lkh4swkv52mi>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
 <CACPK8XeROYz_XaB3TvUhdXm7Vm8fjC8yU+mfvA58=_FiDrBy-g@mail.gmail.com>
 <1b2fddf8-c0a6-4afa-8ad0-f280dea1607f@app.fastmail.com>
 <f4hvrslynlgmxu4a2gogc5idvumskhaalxgwildy56yqk2wz7d@lkh4swkv52mi>
Message-ID: <20230928061449.xxqhyyrg6e357dn2@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Sep 27, 2023 at 04:01:58PM -0700, Bjorn Andersson wrote:
> On Wed, Sep 27, 2023 at 10:43:16AM +0200, Arnd Bergmann wrote:
> > On Wed, Sep 27, 2023, at 04:25, Joel Stanley wrote:
> > > On Mon, 25 Sept 2023 at 09:55, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:
> > >>
> > >> this series converts all platform drivers below drivers/soc to use
> > >> .remove_new(). The motivation is to get rid of an integer return code
> > >> that is (mostly) ignored by the platform driver core and error prone on
> > >> the driver side.
> > >>
> > >> See commit 5c5a7680e67b ("platform: Provide a remove callback that
> > >> returns no value") for an extended explanation and the eventual goal.
> > >>
> > >> As there is no single maintainer team for drivers/soc, I suggest the
> > >> individual maintainers to pick up "their" patches.
> > >
> > > I'd be happy if Arnd merged the lot at once. Arnd, what do you think?
> > >
> > > If that will be too messy then I understand. I have queued the aspeed
> > > ones locally and will push that out if we decide that's the best way
> > > to go.
> > 
> > The main downside of merging it all at once through the soc tree
> > is that there may be patches that conflict with other work going on
> > in individual drivers.
> > 
> > What I'd suggest doing here is:
> > 
> > - have platform maintainers pick up patches for their drivers
> >   if that is their preference for any reason
> 
> I'd prefer this for the qcom drivers at least, please let me know if you
> would like me to proceed.

I can send a pull request as Arnd suggested. So iff you want the qcom
drivers not be a part of that PR, just make sure they appear in next
during the next week. :-)

(I'm not sure if "this" in your last quoted sentence is "platform
maintainers pick up" or "merging it all at once through the soc tree". I
think you mean the former. Still if you don't want me to pick up the
qcom patches and won't manage to make them appear in next via your tree,
I ask you to tell me explicitly to skip these in my PR.)

Best regards and thanks,
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230928/96911d85/attachment-0001.sig>
