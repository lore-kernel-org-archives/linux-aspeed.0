From: Peter Yin <peteryin.openbmc@gmail.com>
Date: Mon, 29 Apr 2024 22:54:14 +0800
Subject: [PATCH v8 1/1] drivers: watchdog: revise watchdog bootstatus
In-Reply-To: <d231737bfa9f3dd3c0a4370ab2e86557a407980d.camel@codeconstruct.com.au>
References: <20240428142937.785925-1-peteryin.openbmc@gmail.com>
 <20240428142937.785925-2-peteryin.openbmc@gmail.com> <d231737bfa9f3dd3c0a4370ab2e86557a407980d.camel@codeconstruct.com.au>
Message-ID: <CAPSyxFRG8mooBg1QWZk8sw=cWzoUQqk=WnyAtgPfRBmQRKtvaQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Andrew,
    I am not sure how to add the Fixes tag, Is it like this?

Fixes: 6a6c7b006e5c (watchdog: aspeed: Add support for
aspeed,reset-mask DT property).
Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>

Is it the correct commit ID or should I base on which commit ID?

Thanks,
Peter.

On Mon, Apr 29, 2024 at 9:50?AM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> Hi Peter,
>
> Thanks for reworking the patch to reduce the branching in probe(), it
> looks a lot tidier.
>
> First, regarding the patch subject, looking at recent changes to the
> watchdog subsystem the desired pattern appears to be `watchdog:
> <controller>: <description>`. I expect you should change it to
> `watchdog: aspeed: Revise handling of bootstatus`. Currently the
> subject contains `drivers: ` which feels a bit redundant, and fails to
> mention `aspeed`, which will bound the scope of the patch for people
> skimming the mailing list.
>
> I have a bit of feedback below. It looks like a lot but mostly it's
> nitpicking at how we're naming things. Maybe the comments are a bit
> subjective but I think addressing them will help provide consistency
> for readers of the code.
>
> On Sun, 2024-04-28 at 22:29 +0800, Peter Yin wrote:
> > Regarding the AST2600 specification, the WDTn Timeout Status Register
> > (WDT10) has bit 1 reserved. Bit 1 of the status register indicates
> > on ast2500 if the boot was from the second boot source.
> > It does not indicate that the most recent reset was triggered by
> > the watchdog. The code should just be changed to set WDIOF_CARDRESET
> > if bit 0 of the status register is set. However, this bit can be clear when
> > watchdog register 0x0c bit1(Reset System after timeout) is enabled.
> > Thereforce include SCU register to veriy WDIOF_EXTERN1 and WDIOF_CARDRESET
> > in ast2600 SCU74 or ast2400/ast2500 SCU3C.
> >
> > Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> > ---
> >  drivers/watchdog/aspeed_wdt.c | 78 +++++++++++++++++++++++++++++++----
> >  1 file changed, 70 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> > index b4773a6aaf8c..4393625c2e96 100644
> > --- a/drivers/watchdog/aspeed_wdt.c
> > +++ b/drivers/watchdog/aspeed_wdt.c
> > @@ -11,10 +11,12 @@
> >  #include <linux/io.h>
> >  #include <linux/kernel.h>
> >  #include <linux/kstrtox.h>
> > +#include <linux/mfd/syscon.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> >  #include <linux/of_irq.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> >  #include <linux/watchdog.h>
> >
> >  static bool nowayout = WATCHDOG_NOWAYOUT;
> > @@ -22,10 +24,32 @@ module_param(nowayout, bool, 0);
> >  MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
> >                               __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> >
> > +//AST SCU Register
>
> Can you unpack in the comment which register this refers to? Also I
> have a mild preference for `/* */-style comments and against the `//`-
> style comments, but I won't hold the patch up on it.
>
> > +#define POWERON_RESET_FLAG           BIT(0)
> > +#define EXTERN_RESET_FLAG            BIT(1)
>
> IMO an `AST_` prefix would be helpful. At least, it would help me
> orient myself when reading use of the macro in the code.
>
> Further, can we include `SCU` in the symbol name to indicate we're not
> actually referring to a register in the WDT controller (and update the
> register and flag macros below as well)?
>
> Finally, including an indication of the register name (System Reset
> Control/Status Register for the AST2500, System Reset Status Register
> for the AST2600) is helpful too:
>
> Perhaps:
>
> ```
> #define AST_SCU_SYS_RESET_POWERON_FLAG ...
> #define AST_SCU_SYS_RESET_EXTERN_FLAG ...
> ```
>
> I'd like to see these approaches applied to the other macros you've
> introduced as well.
>
> > +
> > +#define AST2400_AST2500_SYSTEM_RESET_EVENT   0x3C
>
> If the AST2500 register offset is compatible with the AST2400 then IMO
> you can drop `_AST2500` from the macro name. The location of relevance
> for a potential bug is the assignment into the `reset_event` struct
> member below, which is straight-forward to inspect for correctness.
>
> With the prior requests in mind I'd propose:
>
> ```
> #define AST2400_SCU_SYS_RESET_STATUS ...
> ```
>
> > +#define   AST2400_WATCHDOG_RESET_FLAG        BIT(1)
> > +#define   AST2400_RESET_FLAG_CLEAR   GENMASK(2, 0)
> > +
> > +#define   AST2500_WATCHDOG_RESET_FLAG        GENMASK(4, 2)
>
> While the individual bits in the register are flags, we're extracting a
> collection of the bits from the register. My feeling is that we should
> s/_FLAG/_MASK/ in the macro names, including
> `AST2400_WATCHDOG_RESET_FLAG` for consistency (even though it is only a
> single-bit mask).
>
> > +#define   AST2500_RESET_FLAG_CLEAR   (AST2500_WATCHDOG_RESET_FLAG | \
> > +                                      POWERON_RESET_FLAG | EXTERN_RESET_FLAG)
> > +
> > +#define AST2600_SYSTEM_RESET_EVENT   0x74
> > +#define   AST2600_WATCHDOG_RESET_FLAG   GENMASK(31, 16)
> > +#define   AST2600_RESET_FLAG_CLEAR   (AST2600_WATCHDOG_RESET_FLAG | \
> > +                                      POWERON_RESET_FLAG | EXTERN_RESET_FLAG)
> > +
> >  struct aspeed_wdt_config {
> >       u32 ext_pulse_width_mask;
> >       u32 irq_shift;
> >       u32 irq_mask;
> > +     const char *compatible;
>
> Hmm, a compatible string for what though? From the looks of the code,
> this is for the SCU. I think it would be be helpful to prefix this with
> `scu_` to make it clear, though see the struct-style consideration
> below.
>
> > +     u32 reset_event;
>
> The datasheets refer to the register as 'status' and not 'event', so I
> suggest we use `reset_status` here. I also prefer we suffix this with
> `_reg` to actively differentiate it from the other field types (_flag)
> we're defining (so `reset_status_reg`.
>
> > +     u32 watchdog_reset_flag;
> > +     u32 extern_reset_flag;
>
> s/_flag/_mask/ if we have consensus on that macro name discussion
> above.
>
> > +     u32 reset_flag_clear;
>
> I'd prefix these with `scu_` as well. Or perhaps a nested struct?
>
> struct aspeed_wdt_config {
>     ...
>     struct {
>         const char *compatible;
>         u32 reset_event_reg;
>         u32 watchdog_reset_mask;
>         u32 extern_reset_mask;
>         u32 reset_flag_clear;
>    } scu;
>
> That way the accesses look like wdt->cfg->scu.reset_event_reg` and
> provide some context via the type system instead of deferring to object
> naming convention.
>
> >  };
> >
> >  struct aspeed_wdt {
> > @@ -39,18 +63,33 @@ static const struct aspeed_wdt_config ast2400_config = {
> >       .ext_pulse_width_mask = 0xff,
> >       .irq_shift = 0,
> >       .irq_mask = 0,
> > +     .compatible = "aspeed,ast2400-scu",
> > +     .reset_event = AST2400_AST2500_SYSTEM_RESET_EVENT,
> > +     .watchdog_reset_flag = AST2400_WATCHDOG_RESET_FLAG,
> > +     .extern_reset_flag = 0,
> > +     .reset_flag_clear = AST2400_RESET_FLAG_CLEAR,
> >  };
> >
> >  static const struct aspeed_wdt_config ast2500_config = {
> >       .ext_pulse_width_mask = 0xfffff,
> >       .irq_shift = 12,
> >       .irq_mask = GENMASK(31, 12),
> > +     .compatible = "aspeed,ast2500-scu",
> > +     .reset_event = AST2400_AST2500_SYSTEM_RESET_EVENT,
> > +     .watchdog_reset_flag = AST2500_WATCHDOG_RESET_FLAG,
> > +     .extern_reset_flag = EXTERN_RESET_FLAG,
> > +     .reset_flag_clear = AST2500_RESET_FLAG_CLEAR,
> >  };
> >
> >  static const struct aspeed_wdt_config ast2600_config = {
> >       .ext_pulse_width_mask = 0xfffff,
> >       .irq_shift = 0,
> >       .irq_mask = GENMASK(31, 10),
> > +     .compatible = "aspeed,ast2600-scu",
> > +     .reset_event = AST2600_SYSTEM_RESET_EVENT,
> > +     .watchdog_reset_flag = AST2600_WATCHDOG_RESET_FLAG,
> > +     .extern_reset_flag = EXTERN_RESET_FLAG,
> > +     .reset_flag_clear = AST2600_RESET_FLAG_CLEAR,
> >  };
> >
> >  static const struct of_device_id aspeed_wdt_of_table[] = {
> > @@ -310,6 +349,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
> >       const struct of_device_id *ofdid;
> >       struct aspeed_wdt *wdt;
> >       struct device_node *np;
> > +     struct regmap *scu_base;
>
> I don't think it's necessary to have the `_base` suffix as we're not
> dealing directly with a mapped address.
>
> >       const char *reset_type;
> >       u32 duration;
> >       u32 status;
> > @@ -458,14 +498,36 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
> >               writel(duration - 1, wdt->base + WDT_RESET_WIDTH);
> >       }
> >
> > -     status = readl(wdt->base + WDT_TIMEOUT_STATUS);
> > -     if (status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY) {
>
> Dropping this condition suggests the patch is a fix. Has there been any
> discussion of adding a Fixes: tag?
>
> Andrew
