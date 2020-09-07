From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 7 Sep 2020 09:27:36 +0530
Subject: [PATCH 0/6] mmc: Set PROBE_PREFER_ASYNCHRONOUS for all host
 drivers
In-Reply-To: <CAFBinCBcbEpHX7eUbznuDo6oKO_9JrOK2w+Bx1=e-bwuS609bw@mail.gmail.com>
References: <20200903232441.2694866-1-dianders@chromium.org>
 <CAFBinCBcbEpHX7eUbznuDo6oKO_9JrOK2w+Bx1=e-bwuS609bw@mail.gmail.com>
Message-ID: <CANAwSgTv2ZAvPKG2aChs8NwZL32TF+MtcaFbehQWWSf_TFXF6A@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Martin.

On Sat, 5 Sep 2020 at 03:24, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Douglas,
>
> On Fri, Sep 4, 2020 at 1:25 AM Douglas Anderson <dianders@chromium.org> wrote:
> >
> > As per discussion [1], it seems like it should be quite safe to turn
> > on PROBE_PREFER_ASYNCHRONOUS for all sd/mmc host controllers.  Let's
> > give it a shot.  For some discussion about this flag, see the commit
> > message for commit 3d3451124f3d ("mmc: sdhci-msm: Prefer asynchronous
> > probe").
> can this somehow change the order in which the MMC drivers end up loading?
> on Amlogic SoCs we have up to three MMC controllers, some SoCs even
> use two different MMC controller IPs (and therefore two different
> drivers).
> so far the MMC controller naming (/dev/mmcblk* etc.) was consistent -
> can that change with this patch?
>

We could resolve this by setting up aliases for mmc nodes in the dts.

> apologies if this has been discussed and answered anywhere
>
>
> Best regards,
> Martin

Best regards
-Anand
