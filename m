From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
Date: Tue, 22 Dec 2020 02:13:33 +0000
Subject: [PATCH v3 3/5] ipmi: kcs: aspeed: Adapt to new LPC DTS layout
In-Reply-To: <c1b6e2fe-5b22-ac67-f0eb-159499e06d2b@linux.intel.com>
References: <20201221055623.31463-1-chiawei_wang@aspeedtech.com>
 <20201221055623.31463-4-chiawei_wang@aspeedtech.com>
 <12d347b6-168b-11d2-b906-18164afb1724@linux.intel.com>
 <c1b6e2fe-5b22-ac67-f0eb-159499e06d2b@linux.intel.com>
Message-ID: <HK0PR06MB377929E6EA4A1EECEB86E6AD91DF0@HK0PR06MB3779.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Haiyue,

> -----Original Message-----
> From: Haiyue Wang <haiyue.wang@linux.intel.com>
> Sent: Monday, December 21, 2020 3:59 PM
> Subject: Re: [PATCH v3 3/5] ipmi: kcs: aspeed: Adapt to new LPC DTS layout
> 
> 
> On 12/21/2020 15:53, Haiyue Wang wrote:
> > On 12/21/2020 13:56, Chia-Wei, Wang wrote:
> >> Add check against LPC device v2 compatible string to ensure that the
> >> fixed device tree layout is adopted.
> >> The LPC register offsets are also fixed accordingly.
> >>
> >> Signed-off-by: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>
> >> ---
> >> ? drivers/char/ipmi/kcs_bmc_aspeed.c | 35
> >> ++++++++++++++++++------------
> >> ? 1 file changed, 21 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c
> >> b/drivers/char/ipmi/kcs_bmc_aspeed.c
> >> index a140203c079b..6283bfef4ea7 100644
> >> --- a/drivers/char/ipmi/kcs_bmc_aspeed.c
> >> +++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
> >> @@ -27,7 +27,6 @@
> >> ? ? #define KCS_CHANNEL_MAX???? 4
> >> ? -/* mapped to lpc-bmc at 0 IO space */
> >> ? #define LPC_HICR0??????????? 0x000
> >> ? #define???? LPC_HICR0_LPC3E????????? BIT(7)
> >> ? #define???? LPC_HICR0_LPC2E????????? BIT(6) @@ -52,15
> +51,13 @@
> >> ? #define LPC_STR1???????????? 0x03C
> >> ? #define LPC_STR2???????????? 0x040
> >> ? #define LPC_STR3???????????? 0x044
> >> -
> >> -/* mapped to lpc-host at 80 IO space */ -#define
> LPC_HICRB
> >> 0x080
> >> +#define LPC_HICRB??????????? 0x100
> >> ? #define???? LPC_HICRB_IBFIF4???????? BIT(1)
> >> ? #define???? LPC_HICRB_LPC4E????????? BIT(0) -#define
> LPC_LADR4
> >> 0x090 -#define LPC_IDR4???????????? 0x094 -#define
> LPC_ODR4
> >> 0x098 -#define LPC_STR4???????????? 0x09C
> >> +#define LPC_LADR4??????????? 0x110
> >> +#define LPC_IDR4???????????? 0x114
> >> +#define LPC_ODR4???????????? 0x118
> >> +#define LPC_STR4???????????? 0x11C
> >> ? ? struct aspeed_kcs_bmc {
> >> ????? struct regmap *map;
> >> @@ -345,15 +342,25 @@ static int aspeed_kcs_probe(struct
> >> platform_device *pdev)
> >> ? {
> >> ????? struct device *dev = &pdev->dev;
> >> ????? struct kcs_bmc *kcs_bmc;
> >> -??? struct device_node *np;
> >> +??? struct device_node *kcs_np;
> >> +??? struct device_node *lpc_np;
> >> ????? int rc;
> >
> > I think you can just use 'np' to do LPC compatible checking:
> >
> > np = pdev->dev.of_node->parent;
> >
> > if (!of_device_is_compatible(lpc_np, "aspeed,ast2400-lpc-v2") &&
> > ??? !of_device_is_compatible(lpc_np, "aspeed,ast2500-lpc-v2") &&
> > ??? !of_device_is_compatible(lpc_np, "aspeed,ast2600-lpc-v2")) {
> > ????dev_err(dev, "unsupported LPC device binding\n");
> > ????return -ENODEV;
> > }
> >
> Typo:
> 
> if (!of_device_is_compatible(np, "aspeed,ast2400-lpc-v2") &&
>  ??? !of_device_is_compatible(np, "aspeed,ast2500-lpc-v2") &&
>  ??? !of_device_is_compatible(np, "aspeed,ast2600-lpc-v2")) {
>  ????dev_err(dev, "unsupported LPC device binding\n");
>  ????return -ENODEV;
> }
Thanks for the suggestion. Will revise the code after collecting reviewers' feedback.

> 
> 
> >
> > before:
> >
> > np = pdev->dev.of_node;
> > if (of_device_is_compatible(np, "aspeed,ast2400-kcs-bmc") ||
> > ??? of_device_is_compatible(np, "aspeed,ast2500-kcs-bmc"))
> >
> > Then the patch is clear. ;-)
> >
> >> -??? np = pdev->dev.of_node;
> >> -??? if (of_device_is_compatible(np, "aspeed,ast2400-kcs-bmc") ||
> >> -??????????? of_device_is_compatible(np,
> "aspeed,ast2500-kcs-bmc"))
> >> +??? kcs_np = dev->of_node;
> >> +??? lpc_np = kcs_np->parent;
> >> +
> >> +??? if (!of_device_is_compatible(lpc_np, "aspeed,ast2400-lpc-v2") &&
> >> +??????? !of_device_is_compatible(lpc_np, "aspeed,ast2500-lpc-v2")
> &&
> >> +??????? !of_device_is_compatible(lpc_np, "aspeed,ast2600-lpc-v2")) {
> >> +??????? dev_err(dev, "unsupported LPC device binding\n");
> >> +??????? return -ENODEV;
> >> +??? }
> >> +
> >> +??? if (of_device_is_compatible(kcs_np, "aspeed,ast2400-kcs-bmc") ||
> >> +??????????? of_device_is_compatible(kcs_np,
> >> +"aspeed,ast2500-kcs-bmc"))
> >> ????????? kcs_bmc = aspeed_kcs_probe_of_v1(pdev);
> >> -??? else if (of_device_is_compatible(np,
> >> "aspeed,ast2400-kcs-bmc-v2") ||
> >> -??????????? of_device_is_compatible(np,
> >> "aspeed,ast2500-kcs-bmc-v2"))
> >> +??? else if (of_device_is_compatible(kcs_np,
> >> "aspeed,ast2400-kcs-bmc-v2") ||
> >> +??????????? of_device_is_compatible(kcs_np,
> >> "aspeed,ast2500-kcs-bmc-v2"))
> >> ????????? kcs_bmc = aspeed_kcs_probe_of_v2(pdev);
> >> ????? else
> >> ????????? return -EINVAL;
