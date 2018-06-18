From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 18 Jun 2018 15:25:28 +0930
Subject: [PATCH v2 1/4] gpio: aspeed: Rework register type accessors
In-Reply-To: <20180618045352.9489-2-benh@kernel.crashing.org>
References: <20180618045352.9489-1-benh@kernel.crashing.org>
 <20180618045352.9489-2-benh@kernel.crashing.org>
Message-ID: <1529301328.2976871.1411343304.55FBD1AE@webmail.messagingengine.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 18 Jun 2018, at 14:23, Benjamin Herrenschmidt wrote:
> Use a single accessor function for all register types instead
> of several spread around. This will make it easier/cleaner
> to introduce new registers and keep the mechanism in one
> place.
> 
> The big switch/case is optimized at compile time since the
> switch value is a constant.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  drivers/gpio/gpio-aspeed.c | 118 ++++++++++++++++++++++---------------
>  1 file changed, 69 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
> index b31ae16170e7..c9baeeb7f0cc 100644
> --- a/drivers/gpio/gpio-aspeed.c
> +++ b/drivers/gpio/gpio-aspeed.c
> @@ -127,12 +127,21 @@ static const struct aspeed_gpio_bank 
> aspeed_gpio_banks[] = {
>  	},
>  };
>  
> -#define GPIO_BANK(x)	((x) >> 5)
> -#define GPIO_OFFSET(x)	((x) & 0x1f)
> -#define GPIO_BIT(x)	BIT(GPIO_OFFSET(x))
> +enum aspeed_gpio_reg {
> +	reg_val,
> +	reg_dir,
> +	reg_irq_enable,
> +	reg_irq_type0,
> +	reg_irq_type1,
> +	reg_irq_type2,
> +	reg_irq_status,
> +	reg_debounce_sel1,
> +	reg_debounce_sel2,
> +	reg_tolerance,
> +};
>  
> -#define GPIO_DATA	0x00
> -#define GPIO_DIR	0x04
> +#define GPIO_VAL_VALUE	0x00
> +#define GPIO_VAL_DIR	0x04
>  
>  #define GPIO_IRQ_ENABLE	0x00
>  #define GPIO_IRQ_TYPE0	0x04
> @@ -143,6 +152,40 @@ static const struct aspeed_gpio_bank 
> aspeed_gpio_banks[] = {
>  #define GPIO_DEBOUNCE_SEL1 0x00
>  #define GPIO_DEBOUNCE_SEL2 0x04
>  
> +/* This will be resolved at compile time */
> +static inline void __iomem *bank_reg(struct aspeed_gpio *gpio,
> +				     const struct aspeed_gpio_bank *bank,
> +				     const enum aspeed_gpio_reg reg)
> +{
> +	switch (reg) {
> +	case reg_val:
> +		return gpio->base + bank->val_regs + GPIO_VAL_VALUE;
> +	case reg_dir:
> +		return gpio->base + bank->val_regs + GPIO_VAL_DIR;
> +	case reg_irq_enable:
> +		return gpio->base + bank->irq_regs + GPIO_IRQ_ENABLE;
> +	case reg_irq_type0:
> +		return gpio->base + bank->irq_regs + GPIO_IRQ_TYPE0;
> +	case reg_irq_type1:
> +		return gpio->base + bank->irq_regs + GPIO_IRQ_TYPE1;
> +	case reg_irq_type2:
> +		return gpio->base + bank->irq_regs + GPIO_IRQ_TYPE2;
> +	case reg_irq_status:
> +		return gpio->base + bank->irq_regs + GPIO_IRQ_STATUS;
> +	case reg_debounce_sel1:
> +		return gpio->base + bank->debounce_regs + GPIO_DEBOUNCE_SEL1;
> +	case reg_debounce_sel2:
> +		return gpio->base + bank->debounce_regs + GPIO_DEBOUNCE_SEL2;
> +	case reg_tolerance:
> +		return gpio->base + bank->tolerance_regs;
> +	}
> +	BUG_ON(1);
> +}
> +
> +#define GPIO_BANK(x)	((x) >> 5)
> +#define GPIO_OFFSET(x)	((x) & 0x1f)
> +#define GPIO_BIT(x)	BIT(GPIO_OFFSET(x))
> +
>  #define _GPIO_SET_DEBOUNCE(t, o, i) ((!!((t) & BIT(i))) << 
> GPIO_OFFSET(o))
>  #define GPIO_SET_DEBOUNCE1(t, o) _GPIO_SET_DEBOUNCE(t, o, 1)
>  #define GPIO_SET_DEBOUNCE2(t, o) _GPIO_SET_DEBOUNCE(t, o, 0)
> @@ -201,27 +244,12 @@ static inline bool have_output(struct aspeed_gpio 
> *gpio, unsigned int offset)
>  	return !props || (props->output & GPIO_BIT(offset));
>  }
>  
> -static void __iomem *bank_val_reg(struct aspeed_gpio *gpio,
> -		const struct aspeed_gpio_bank *bank,
> -		unsigned int reg)
> -{
> -	return gpio->base + bank->val_regs + reg;
> -}
> -
> -static void __iomem *bank_irq_reg(struct aspeed_gpio *gpio,
> -		const struct aspeed_gpio_bank *bank,
> -		unsigned int reg)
> -{
> -	return gpio->base + bank->irq_regs + reg;
> -}
> -
>  static int aspeed_gpio_get(struct gpio_chip *gc, unsigned int offset)
>  {
>  	struct aspeed_gpio *gpio = gpiochip_get_data(gc);
>  	const struct aspeed_gpio_bank *bank = to_bank(offset);
>  
> -	return !!(ioread32(bank_val_reg(gpio, bank, GPIO_DATA))
> -			& GPIO_BIT(offset));
> +	return !!(ioread32(bank_reg(gpio, bank, reg_val)) & GPIO_BIT(offset));
>  }
>  
>  static void __aspeed_gpio_set(struct gpio_chip *gc, unsigned int 
> offset,
> @@ -232,7 +260,7 @@ static void __aspeed_gpio_set(struct gpio_chip *gc, 
> unsigned int offset,
>  	void __iomem *addr;
>  	u32 reg;
>  
> -	addr = bank_val_reg(gpio, bank, GPIO_DATA);
> +	addr = bank_reg(gpio, bank, reg_val);
>  	reg = gpio->dcache[GPIO_BANK(offset)];
>  
>  	if (val)
> @@ -269,8 +297,8 @@ static int aspeed_gpio_dir_in(struct gpio_chip *gc, 
> unsigned int offset)
>  
>  	spin_lock_irqsave(&gpio->lock, flags);
>  
> -	reg = ioread32(bank_val_reg(gpio, bank, GPIO_DIR));
> -	iowrite32(reg & ~GPIO_BIT(offset), bank_val_reg(gpio, bank, GPIO_DIR));
> +	reg = ioread32(bank_reg(gpio, bank, reg_dir));
> +	iowrite32(reg & ~GPIO_BIT(offset), bank_reg(gpio, bank, reg_dir));
>  
>  	spin_unlock_irqrestore(&gpio->lock, flags);
>  
> @@ -291,8 +319,8 @@ static int aspeed_gpio_dir_out(struct gpio_chip *gc,
>  	spin_lock_irqsave(&gpio->lock, flags);
>  
>  	__aspeed_gpio_set(gc, offset, val);
> -	reg = ioread32(bank_val_reg(gpio, bank, GPIO_DIR));
> -	iowrite32(reg | GPIO_BIT(offset), bank_val_reg(gpio, bank, GPIO_DIR));
> +	reg = ioread32(bank_reg(gpio, bank, reg_dir));
> +	iowrite32(reg | GPIO_BIT(offset), bank_reg(gpio, bank, reg_dir));
>  
>  	spin_unlock_irqrestore(&gpio->lock, flags);
>  
> @@ -314,7 +342,7 @@ static int aspeed_gpio_get_direction(struct 
> gpio_chip *gc, unsigned int offset)
>  
>  	spin_lock_irqsave(&gpio->lock, flags);
>  
> -	val = ioread32(bank_val_reg(gpio, bank, GPIO_DIR)) & GPIO_BIT(offset);
> +	val = ioread32(bank_reg(gpio, bank, reg_dir)) & GPIO_BIT(offset);
>  
>  	spin_unlock_irqrestore(&gpio->lock, flags);
>  
> @@ -358,7 +386,7 @@ static void aspeed_gpio_irq_ack(struct irq_data *d)
>  	if (rc)
>  		return;
>  
> -	status_addr = bank_irq_reg(gpio, bank, GPIO_IRQ_STATUS);
> +	status_addr = bank_reg(gpio, bank, reg_irq_status);
>  
>  	spin_lock_irqsave(&gpio->lock, flags);
>  	iowrite32(bit, status_addr);
> @@ -378,7 +406,7 @@ static void aspeed_gpio_irq_set_mask(struct irq_data 
> *d, bool set)
>  	if (rc)
>  		return;
>  
> -	addr = bank_irq_reg(gpio, bank, GPIO_IRQ_ENABLE);
> +	addr = bank_reg(gpio, bank, reg_irq_enable);
>  
>  	spin_lock_irqsave(&gpio->lock, flags);
>  
> @@ -442,17 +470,17 @@ static int aspeed_gpio_set_type(struct irq_data 
> *d, unsigned int type)
>  
>  	spin_lock_irqsave(&gpio->lock, flags);
>  
> -	addr = bank_irq_reg(gpio, bank, GPIO_IRQ_TYPE0);
> +	addr = bank_reg(gpio, bank, reg_irq_type0);
>  	reg = ioread32(addr);
>  	reg = (reg & ~bit) | type0;
>  	iowrite32(reg, addr);
>  
> -	addr = bank_irq_reg(gpio, bank, GPIO_IRQ_TYPE1);
> +	addr = bank_reg(gpio, bank, reg_irq_type1);
>  	reg = ioread32(addr);
>  	reg = (reg & ~bit) | type1;
>  	iowrite32(reg, addr);
>  
> -	addr = bank_irq_reg(gpio, bank, GPIO_IRQ_TYPE2);
> +	addr = bank_reg(gpio, bank, reg_irq_type2);
>  	reg = ioread32(addr);
>  	reg = (reg & ~bit) | type2;
>  	iowrite32(reg, addr);
> @@ -477,7 +505,7 @@ static void aspeed_gpio_irq_handler(struct irq_desc *desc)
>  	for (i = 0; i < ARRAY_SIZE(aspeed_gpio_banks); i++) {
>  		const struct aspeed_gpio_bank *bank = &aspeed_gpio_banks[i];
>  
> -		reg = ioread32(bank_irq_reg(data, bank, GPIO_IRQ_STATUS));
> +		reg = ioread32(bank_reg(data, bank, reg_irq_status));
>  
>  		for_each_set_bit(p, &reg, 32) {
>  			girq = irq_find_mapping(gc->irq.domain, i * 32 + p);
> @@ -549,21 +577,21 @@ static int aspeed_gpio_reset_tolerance(struct 
> gpio_chip *chip,
>  					unsigned int offset, bool enable)
>  {
>  	struct aspeed_gpio *gpio = gpiochip_get_data(chip);
> -	const struct aspeed_gpio_bank *bank;
>  	unsigned long flags;
> +	void __iomem *treg;
>  	u32 val;
>  
> -	bank = to_bank(offset);
> +	treg = bank_reg(gpio, to_bank(offset), reg_tolerance);
>  
>  	spin_lock_irqsave(&gpio->lock, flags);
> -	val = readl(gpio->base + bank->tolerance_regs);
> +	val = readl(treg);
>  
>  	if (enable)
>  		val |= GPIO_BIT(offset);
>  	else
>  		val &= ~GPIO_BIT(offset);
>  
> -	writel(val, gpio->base + bank->tolerance_regs);
> +	writel(val, treg);
>  	spin_unlock_irqrestore(&gpio->lock, flags);
>  
>  	return 0;
> @@ -582,13 +610,6 @@ static void aspeed_gpio_free(struct gpio_chip 
> *chip, unsigned int offset)
>  	pinctrl_gpio_free(chip->base + offset);
>  }
>  
> -static inline void __iomem *bank_debounce_reg(struct aspeed_gpio *gpio,
> -		const struct aspeed_gpio_bank *bank,
> -		unsigned int reg)
> -{
> -	return gpio->base + bank->debounce_regs + reg;
> -}
> -
>  static int usecs_to_cycles(struct aspeed_gpio *gpio, unsigned long 
> usecs,
>  		u32 *cycles)
>  {
> @@ -666,11 +687,11 @@ static void configure_timer(struct aspeed_gpio 
> *gpio, unsigned int offset,
>  	void __iomem *addr;
>  	u32 val;
>  
> -	addr = bank_debounce_reg(gpio, bank, GPIO_DEBOUNCE_SEL1);
> +	addr = bank_reg(gpio, bank, reg_debounce_sel1);
>  	val = ioread32(addr);
>  	iowrite32((val & ~mask) | GPIO_SET_DEBOUNCE1(timer, offset), addr);
>  
> -	addr = bank_debounce_reg(gpio, bank, GPIO_DEBOUNCE_SEL2);
> +	addr = bank_reg(gpio, bank, reg_debounce_sel2);
>  	val = ioread32(addr);
>  	iowrite32((val & ~mask) | GPIO_SET_DEBOUNCE2(timer, offset), addr);
>  }
> @@ -904,9 +925,8 @@ static int __init aspeed_gpio_probe(struct 
> platform_device *pdev)
>  
>  	/* Populate it with initial values read from the HW */
>  	for (i = 0; i < banks; i++) {
> -		const struct aspeed_gpio_bank *bank = &aspeed_gpio_banks[i];
> -		gpio->dcache[i] = ioread32(gpio->base + bank->val_regs +
> -					   GPIO_DATA);
> +		void __iomem *addr = bank_reg(gpio, &aspeed_gpio_banks[i], reg_val);
> +		gpio->dcache[i] = ioread32(addr);
>  	}
>  
>  	rc = devm_gpiochip_add_data(&pdev->dev, &gpio->chip, gpio);
> -- 
> 2.17.1
> 
