From: Olof Johansson <olof@lixom.net>
Date: Sun, 18 Sep 2022 20:44:27 -0700
Subject: [PATCH v2 0/2] Fix console probe delay when stdout-path isn't set
In-Reply-To: <YwS5J3effuHQJRZ5@kroah.com>
References: <20220701012647.2007122-1-saravanak@google.com> <YwS5J3effuHQJRZ5@kroah.com>
Message-ID: <CAOesGMivJ5Q-jdeGKw32yhjmNiYctHjpEAnoMMRghYqWD2m2tw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Aug 23, 2022 at 8:37 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jun 30, 2022 at 06:26:38PM -0700, Saravana Kannan wrote:
> > These patches are on top of driver-core-next.
> >
> > Even if stdout-path isn't set in DT, this patch should take console
> > probe times back to how they were before the deferred_probe_timeout
> > clean up series[1].
>
> Now dropped from my queue due to lack of a response to other reviewer's
> questions.

What happened to this patch? I have a 10 second timeout on console
probe on my SiFive Unmatched, and I don't see this flag being set for
the serial driver. In fact, I don't see it anywhere in-tree. I can't
seem to locate another patchset from Saravana around this though, so
I'm not sure where to look for a missing piece for the sifive serial
driver.

This is the second boot time regression (this one not fatal, unlike
the Layerscape PCIe one) from the fw_devlink patchset.

Greg, can you revert the whole set for 6.0, please? It's obviously
nowhere near tested enough to go in and I expect we'll see a bunch of
-stable fixups due to this if we let it remain in.

This seems to be one of the worst releases I've encountered in recent
years on my hardware here due to this patchset. :-(


-Olof
