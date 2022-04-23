From: Marc Zyngier <maz@kernel.org>
Date: Sat, 23 Apr 2022 10:43:44 +0100
Subject: [PATCH 1/2] irqchip/aspeed-i2c-ic: Fix irq_of_parse_and_map()
 return value
In-Reply-To: <3eb57a4c-95b6-0bf5-aa1a-90ee2fd336e1@linaro.org>
References: <20220422104536.61451-1-krzysztof.kozlowski@linaro.org>
 <3eb57a4c-95b6-0bf5-aa1a-90ee2fd336e1@linaro.org>
Message-ID: <875yn0cey7.wl-maz@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, 23 Apr 2022 10:30:53 +0100,
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
> On 22/04/2022 12:45, Krzysztof Kozlowski wrote:
> > The irq_of_parse_and_map() returns 0 on failure, not a negative ERRNO.
> > 
> > Fixes: f48e699ddf70 ("irqchip/aspeed-i2c-ic: Add I2C IRQ controller for Aspeed")
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  drivers/irqchip/irq-aspeed-i2c-ic.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/irqchip/irq-aspeed-i2c-ic.c b/drivers/irqchip/irq-aspeed-i2c-ic.c
> > index a47db16ff960..cef1291ae783 100644
> > --- a/drivers/irqchip/irq-aspeed-i2c-ic.c
> > +++ b/drivers/irqchip/irq-aspeed-i2c-ic.c
> > @@ -77,7 +77,7 @@ static int __init aspeed_i2c_ic_of_init(struct device_node *node,
> >  	}
> >  
> >  	i2c_ic->parent_irq = irq_of_parse_and_map(node, 0);
> > -	if (i2c_ic->parent_irq < 0) {
> > +	if (!i2c_ic->parent_irq) {
> >  		ret = i2c_ic->parent_irq;
> 
> This is wrong (same in patch 2). I will send a v2.

While you're at it, please add a cover letter when sending a series
containing more than a single patch.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
