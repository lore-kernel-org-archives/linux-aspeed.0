From: Olof Johansson <olof@lixom.net>
Date: Wed, 19 Jun 2019 07:12:30 -0700
Subject: [PATCH v3] ARM: configs: Remove useless UEVENT_HELPER_PATH
In-Reply-To: <CAJKOXPd4LVFGgonbsuxii-5Fu5wWhxU9yotLHw+OXsPcxYw_3g@mail.gmail.com>
References: <20190604185229.7393-1-krzk@kernel.org>
 <CAJKOXPd4LVFGgonbsuxii-5Fu5wWhxU9yotLHw+OXsPcxYw_3g@mail.gmail.com>
Message-ID: <20190619141230.rtgeunr23gybv7u2@localhost>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jun 13, 2019 at 04:53:53PM +0200, Krzysztof Kozlowski wrote:
> On Tue, 4 Jun 2019 at 20:52, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > Remove the CONFIG_UEVENT_HELPER_PATH because:
> > 1. It is disabled since commit 1be01d4a5714 ("driver: base: Disable
> >    CONFIG_UEVENT_HELPER by default") as its dependency (UEVENT_HELPER) was
> >    made default to 'n',
> > 2. It is not recommended (help message: "This should not be used today
> >    [...] creates a high system load") and was kept only for ancient
> >    userland,
> > 3. Certain userland specifically requests it to be disabled (systemd
> >    README: "Legacy hotplug slows down the system and confuses udev").
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > For vexpress:
> > Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> >
> > ---
> >
> > Changes since v2:
> > 1. Remove unrelated files.
> > 2. Add Geert's ack.
> >
> > Changes sice v3:
> > 1. Change also mini2440_defconfig.
> > 2. Add more acks.
> 
> Hi Arnd and Olof,
> 
> Do you want to apply it directly or maybe I can send it along with
> other my defconfig pull request?

Oh, just saw v3, since it didn't thread with v2.

Applied already with the equivalent fixups, so we're good.

-Olof
