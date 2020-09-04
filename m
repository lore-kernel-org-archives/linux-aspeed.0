From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Fri, 4 Sep 2020 23:53:32 +0200
Subject: [PATCH 0/6] mmc: Set PROBE_PREFER_ASYNCHRONOUS for all host
 drivers
In-Reply-To: <20200903232441.2694866-1-dianders@chromium.org>
References: <20200903232441.2694866-1-dianders@chromium.org>
Message-ID: <CAFBinCBcbEpHX7eUbznuDo6oKO_9JrOK2w+Bx1=e-bwuS609bw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Douglas,

On Fri, Sep 4, 2020 at 1:25 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> As per discussion [1], it seems like it should be quite safe to turn
> on PROBE_PREFER_ASYNCHRONOUS for all sd/mmc host controllers.  Let's
> give it a shot.  For some discussion about this flag, see the commit
> message for commit 3d3451124f3d ("mmc: sdhci-msm: Prefer asynchronous
> probe").
can this somehow change the order in which the MMC drivers end up loading?
on Amlogic SoCs we have up to three MMC controllers, some SoCs even
use two different MMC controller IPs (and therefore two different
drivers).
so far the MMC controller naming (/dev/mmcblk* etc.) was consistent -
can that change with this patch?

apologies if this has been discussed and answered anywhere


Best regards,
Martin
