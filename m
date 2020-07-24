From: Joel Stanley <joel@jms.id.au>
Date: Fri, 24 Jul 2020 05:32:30 +0000
Subject: [PATCH v2 0/3] ARM: dts: aspeed: fixup wedge40 device tree
In-Reply-To: <20200723230539.17860-1-rentao.bupt@gmail.com>
References: <20200723230539.17860-1-rentao.bupt@gmail.com>
Message-ID: <CACPK8XdiHLcBBhXjCpTZotVPuRj4bFh0x8TFhSj1TBK2xB0SiQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2020 at 23:05, <rentao.bupt@gmail.com> wrote:
>
> From: Tao Ren <rentao.bupt@gmail.com>
>
> The patch series update several devices' settings in Facebook Wedge40
> device tree.
>
> Patch #1 disables a few i2c controllers as they are not being used at
> present.
>
> Patch #2 enables adc device for voltage monitoring.
>
> Patch #3 enables pwm_tacho device for fan control and monitoring.
>
> Tao Ren (3):
>   ARM: dts: aspeed: wedge40: disable a few i2c controllers
>   ARM: dts: aspeed: wedge40: enable adc device
>   ARM: dts: aspeed: wedge40: enable pwm_tacho device

I have merged this series into the aspeed dt-for-5.9 branch.

Cheers,

Joel

>
>  .../boot/dts/aspeed-bmc-facebook-wedge40.dts  | 42 +++++++++++++++----
>  1 file changed, 34 insertions(+), 8 deletions(-)
>
> --
> 2.17.1
>
