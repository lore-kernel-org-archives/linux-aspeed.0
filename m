From: Rob Herring <robh@kernel.org>
Date: Mon, 26 Sep 2022 13:25:05 -0500
Subject: [PATCH v2 0/2] Fix console probe delay when stdout-path isn't set
In-Reply-To: <CAOesGMh5GHCONTQ9M1Ro7zW-hkL_1F7Xt=xRV0vYSfPY=7LYkQ@mail.gmail.com>
References: <20220701012647.2007122-1-saravanak@google.com>
 <YwS5J3effuHQJRZ5@kroah.com> <CAOesGMivJ5Q-jdeGKw32yhjmNiYctHjpEAnoMMRghYqWD2m2tw@mail.gmail.com>
 <YygsEtxKz8dsEstc@kroah.com> <CAOesGMh5GHCONTQ9M1Ro7zW-hkL_1F7Xt=xRV0vYSfPY=7LYkQ@mail.gmail.com>
Message-ID: <CAL_JsqK7auA8coB3DCqSDKw1ept_yQihVs-Me3bvU923os23xg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Sep 19, 2022 at 5:56 PM Olof Johansson <olof@lixom.net> wrote:
>
> On Mon, Sep 19, 2022 at 1:44 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Sun, Sep 18, 2022 at 08:44:27PM -0700, Olof Johansson wrote:
> > > On Tue, Aug 23, 2022 at 8:37 AM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Thu, Jun 30, 2022 at 06:26:38PM -0700, Saravana Kannan wrote:
> > > > > These patches are on top of driver-core-next.
> > > > >
> > > > > Even if stdout-path isn't set in DT, this patch should take console
> > > > > probe times back to how they were before the deferred_probe_timeout
> > > > > clean up series[1].
> > > >
> > > > Now dropped from my queue due to lack of a response to other reviewer's
> > > > questions.
> > >
> > > What happened to this patch? I have a 10 second timeout on console
> > > probe on my SiFive Unmatched, and I don't see this flag being set for
> > > the serial driver. In fact, I don't see it anywhere in-tree. I can't
> > > seem to locate another patchset from Saravana around this though, so
> > > I'm not sure where to look for a missing piece for the sifive serial
> > > driver.
> > >
> > > This is the second boot time regression (this one not fatal, unlike
> > > the Layerscape PCIe one) from the fw_devlink patchset.
> > >
> > > Greg, can you revert the whole set for 6.0, please? It's obviously
> > > nowhere near tested enough to go in and I expect we'll see a bunch of
> > > -stable fixups due to this if we let it remain in.
> >
> > What exactly is "the whole set"?  I have the default option fix queued
> > up and will send that to Linus later this week (am traveling back from
> > Plumbers still), but have not heard any problems about any other issues
> > at all other than your report.
>
> I stand corrected in this case, the issue on the Hifive Unmatched was
> a regression due to a PWM clock change -- I just sent a patch for that
> (serial driver fix).
>
> So it seems like as long as the fw_devlink.strict=1 patch is reverted,
> things are back to a working state here.
>
> I still struggle with how the fw_devlink patchset is expected to work
> though, since DT is expected to describe the hardware configuration,
> and it has no knowledge of whether there are drivers that will be
> bound to any referenced supplier devnodes. It's not going to work well
> to assume that they will always be bound, and to add 10 second
> timeouts for those cases isn't a good solution. Seems like the number
> of special cases will keep adding up.

Since the introduction of deferred probe, the kernel has always
assumed if there is a device described, then there is or will be a
driver for it. The result is you can't use new DTs (if they add
providers) with older kernels.

We've ended up with a timeout because no one has come up with a better
way to handle it. What the kernel needs is userspace saying "I'm done
loading modules", but it's debatable whether that's a good solution
too.

Rob
