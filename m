From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 19 Jun 2018 00:38:47 +1000
Subject: [PATCH v2 4/4] gpio: aspeed: Add interfaces for co-processor to
 grab GPIOs
In-Reply-To: <1529331800.1957459.1411835160.214215C7@webmail.messagingengine.com>
References: <20180618045352.9489-1-benh@kernel.crashing.org>
 <20180618045352.9489-5-benh@kernel.crashing.org>
 <1529331800.1957459.1411835160.214215C7@webmail.messagingengine.com>
Message-ID: <f330ef1074ba7a22ff06cc0dbcddd7455f238905.camel@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2018-06-18 at 23:53 +0930, Andrew Jeffery wrote:
> 
> >  static inline int irqd_to_aspeed_gpio_data(struct irq_data *d,
> > -		struct aspeed_gpio **gpio,
> > -		const struct aspeed_gpio_bank **bank,
> > -		u32 *bit)
> > +					   struct aspeed_gpio **gpio,
> > +					   const struct aspeed_gpio_bank **bank,
> > +					   u32 *bit, int *offset)
> >  {
> > -	int offset;
> >  	struct aspeed_gpio *internal;
> >  
> > -	offset = irqd_to_hwirq(d);
> > +	*offset = irqd_to_hwirq(d);
> 
> Nit: Did you intend to set this out parameter before potentially returning an error? I had tried to avoid that up until now.

Yeah it's constant-ish, I don't see why not
 
> >  	internal = irq_data_get_irq_chip_data(d);
> >  
> >  	/* This might be a bit of a questionable place to check */
> > -	if (!have_irq(internal, offset))
> > +	if (!have_irq(internal, *offset))
> >  		return -ENOTSUPP;
> >  
> >  	*gpio = internal;
> > -	*bank = to_bank(offset);
> > -	*bit = GPIO_BIT(offset);
> > +	*bank = to_bank(*offset);
> > +	*bit = GPIO_BIT(*offset);
> >  
> >  	return 0;
> >  }
> > @@ -458,17 +527,23 @@ static void aspeed_gpio_irq_ack(struct irq_data *d)
> >  	struct aspeed_gpio *gpio;
> >  	unsigned long flags;
> >  	void __iomem *status_addr;
> > +	int rc, offset;
> > +	bool copro;
> >  	u32 bit;
> > -	int rc;
> >  
> > -	rc = irqd_to_aspeed_gpio_data(d, &gpio, &bank, &bit);
> > +	rc = irqd_to_aspeed_gpio_data(d, &gpio, &bank, &bit, &offset);
> >  	if (rc)
> >  		return;
> >  
> >  	status_addr = bank_reg(gpio, bank, reg_irq_status);
> >  
> >  	spin_lock_irqsave(&gpio->lock, flags);
> > +	copro = aspeed_gpio_copro_request(gpio, offset);
> > +
> >  	iowrite32(bit, status_addr);
> > +
> > +	if (copro)
> > +		aspeed_gpio_copro_release(gpio, offset);
> >  	spin_unlock_irqrestore(&gpio->lock, flags);
> >  }
> >  
> > @@ -479,15 +554,17 @@ static void aspeed_gpio_irq_set_mask(struct 
> > irq_data *d, bool set)
> >  	unsigned long flags;
> >  	u32 reg, bit;
> >  	void __iomem *addr;
> > -	int rc;
> > +	int rc, offset;
> > +	bool copro;
> >  
> > -	rc = irqd_to_aspeed_gpio_data(d, &gpio, &bank, &bit);
> > +	rc = irqd_to_aspeed_gpio_data(d, &gpio, &bank, &bit, &offset);
> >  	if (rc)
> >  		return;
> >  
> >  	addr = bank_reg(gpio, bank, reg_irq_enable);
> >  
> >  	spin_lock_irqsave(&gpio->lock, flags);
> > +	copro = aspeed_gpio_copro_request(gpio, offset);
> >  
> >  	reg = ioread32(addr);
> >  	if (set)
> > @@ -496,6 +573,8 @@ static void aspeed_gpio_irq_set_mask(struct irq_data 
> > *d, bool set)
> >  		reg &= ~bit;
> >  	iowrite32(reg, addr);
> >  
> > +	if (copro)
> > +		aspeed_gpio_copro_release(gpio, offset);
> >  	spin_unlock_irqrestore(&gpio->lock, flags);
> >  }
> >  
> > @@ -520,9 +599,10 @@ static int aspeed_gpio_set_type(struct irq_data *d, 
> > unsigned int type)
> >  	struct aspeed_gpio *gpio;
> >  	unsigned long flags;
> >  	void __iomem *addr;
> > -	int rc;
> > +	int rc, offset;
> > +	bool copro;
> >  
> > -	rc = irqd_to_aspeed_gpio_data(d, &gpio, &bank, &bit);
> > +	rc = irqd_to_aspeed_gpio_data(d, &gpio, &bank, &bit, &offset);
> >  	if (rc)
> >  		return -EINVAL;
> >  
> > @@ -548,6 +628,7 @@ static int aspeed_gpio_set_type(struct irq_data *d, 
> > unsigned int type)
> >  	}
> >  
> >  	spin_lock_irqsave(&gpio->lock, flags);
> > +	copro = aspeed_gpio_copro_request(gpio, offset);
> >  
> >  	addr = bank_reg(gpio, bank, reg_irq_type0);
> >  	reg = ioread32(addr);
> > @@ -564,6 +645,8 @@ static int aspeed_gpio_set_type(struct irq_data *d, 
> > unsigned int type)
> >  	reg = (reg & ~bit) | type2;
> >  	iowrite32(reg, addr);
> >  
> > +	if (copro)
> > +		aspeed_gpio_copro_release(gpio, offset);
> >  	spin_unlock_irqrestore(&gpio->lock, flags);
> >  
> >  	irq_set_handler_locked(d, handler);
> > @@ -658,11 +741,14 @@ static int aspeed_gpio_reset_tolerance(struct 
> > gpio_chip *chip,
> >  	struct aspeed_gpio *gpio = gpiochip_get_data(chip);
> >  	unsigned long flags;
> >  	void __iomem *treg;
> > +	bool copro;
> >  	u32 val;
> >  
> >  	treg = bank_reg(gpio, to_bank(offset), reg_tolerance);
> >  
> >  	spin_lock_irqsave(&gpio->lock, flags);
> > +	copro = aspeed_gpio_copro_request(gpio, offset);
> > +
> >  	val = readl(treg);
> >  
> >  	if (enable)
> > @@ -671,6 +757,9 @@ static int aspeed_gpio_reset_tolerance(struct 
> > gpio_chip *chip,
> >  		val &= ~GPIO_BIT(offset);
> >  
> >  	writel(val, treg);
> > +
> > +	if (copro)
> > +		aspeed_gpio_copro_release(gpio, offset);
> >  	spin_unlock_irqrestore(&gpio->lock, flags);
> >  
> >  	return 0;
> > @@ -766,6 +855,9 @@ static void configure_timer(struct aspeed_gpio 
> > *gpio, unsigned int offset,
> >  	void __iomem *addr;
> >  	u32 val;
> >  
> > +	/* Note: Debounce timer isn't under control of the command
> > +	 * source registers, so no need to sync with the coprocessor
> > +	 */
> >  	addr = bank_reg(gpio, bank, reg_debounce_sel1);
> >  	val = ioread32(addr);
> >  	iowrite32((val & ~mask) | GPIO_SET_DEBOUNCE1(timer, offset), addr);
> > @@ -912,6 +1004,101 @@ static int aspeed_gpio_set_config(struct 
> > gpio_chip *chip, unsigned int offset,
> >  	return -ENOTSUPP;
> >  }
> >  
> > +/**
> > + * aspeed_gpio_copro_set_ops - Sets the callbacks used for handhsaking 
> > with
> > + *                             the coprocessor for shared GPIO banks
> > + * @ops: The callbacks
> > + * @data: Pointer passed back to the callbacks
> > + */
> > +int aspeed_gpio_copro_set_ops(const struct aspeed_gpio_copro_ops *ops, 
> > void *data)
> > +{
> > +	copro_data = data;
> > +	copro_ops = ops;
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(aspeed_gpio_copro_set_ops);
> > +
> > +/**
> > + * aspeed_gpio_copro_grab_gpio - Mark a GPIO used by the coprocessor. 
> > The entire
> > + *                               bank gets marked and any access from 
> > the ARM will
> > + *                               result in handshaking via callbacks.
> > + * @desc: The GPIO to be marked
> > + */
> > +int aspeed_gpio_copro_grab_gpio(struct gpio_desc *desc)
> > +{
> > +	struct gpio_chip *chip = gpiod_to_chip(desc);
> > +	struct aspeed_gpio *gpio = gpiochip_get_data(chip);
> > +	int rc = 0, bindex, offset = gpio_chip_hwgpio(desc);
> > +	const struct aspeed_gpio_bank *bank = to_bank(offset);
> > +	unsigned long flags;
> > +
> > +	if (!gpio->cf_copro_bankmap)
> > +		gpio->cf_copro_bankmap = kzalloc(gpio->config->nr_gpios >> 3, 
> > GFP_KERNEL);
> > +	if (!gpio->cf_copro_bankmap)
> > +		return -ENOMEM;
> > +	if (offset < 0 || offset > gpio->config->nr_gpios)
> > +		return -EINVAL;
> > +	bindex = offset >> 3;
> > +
> > +	spin_lock_irqsave(&gpio->lock, flags);
> > +
> > +	/* Sanity check, this shouldn't happen */
> > +	if (gpio->cf_copro_bankmap[bindex] == 0xff) {
> > +		rc = -EIO;
> > +		goto bail;
> > +	}
> > +	gpio->cf_copro_bankmap[bindex]++;
> > +
> > +	/* Switch command source */
> > +	if (gpio->cf_copro_bankmap[bindex] == 1)
> > +		aspeed_gpio_change_cmd_source(gpio, bank, bindex,
> > +					      GPIO_CMDSRC_COLDFIRE);
> > +
> > + bail:
> > +	spin_unlock_irqrestore(&gpio->lock, flags);
> > +	return rc;
> > +}
> > +EXPORT_SYMBOL_GPL(aspeed_gpio_copro_grab_gpio);
> > +
> > +/**
> > + * aspeed_gpio_copro_release_gpio - Unmark a GPIO used by the 
> > coprocessor.
> > + * @desc: The GPIO to be marked
> > + */
> > +int aspeed_gpio_copro_release_gpio(struct gpio_desc *desc)
> > +{
> > +	struct gpio_chip *chip = gpiod_to_chip(desc);
> > +	struct aspeed_gpio *gpio = gpiochip_get_data(chip);
> > +	int rc = 0, bindex, offset = gpio_chip_hwgpio(desc);
> > +	const struct aspeed_gpio_bank *bank = to_bank(offset);
> > +	unsigned long flags;
> > +
> > +	if (!gpio->cf_copro_bankmap)
> > +		return -ENXIO;
> > +
> > +	if (offset < 0 || offset > gpio->config->nr_gpios)
> > +		return -EINVAL;
> > +	bindex = offset >> 3;
> > +
> > +	spin_lock_irqsave(&gpio->lock, flags);
> > +
> > +	/* Sanity check, this shouldn't happen */
> > +	if (gpio->cf_copro_bankmap[bindex] == 0) {
> > +		rc = -EIO;
> > +		goto bail;
> > +	}
> > +	gpio->cf_copro_bankmap[bindex]--;
> > +
> > +	/* Switch command source */
> > +	if (gpio->cf_copro_bankmap[bindex] == 0)
> > +		aspeed_gpio_change_cmd_source(gpio, bank, bindex,
> > +					      GPIO_CMDSRC_ARM);
> > + bail:
> > +	spin_unlock_irqrestore(&gpio->lock, flags);
> > +	return rc;
> > +}
> > +EXPORT_SYMBOL_GPL(aspeed_gpio_copro_release_gpio);
> > +
> >  /*
> >   * Any banks not specified in a struct aspeed_bank_props array are 
> > assumed to
> >   * have the properties:
> > @@ -1002,10 +1189,18 @@ static int __init aspeed_gpio_probe(struct 
> > platform_device *pdev)
> >  	if (!gpio->dcache)
> >  		return -ENOMEM;
> >  
> > -	/* Populate it with initial values read from the HW */
> > +	/*
> > +	 * Populate it with initial values read from the HW and switch
> > +	 * all command sources to the ARM by default
> > +	 */
> >  	for (i = 0; i < banks; i++) {
> > -		void __iomem *addr = bank_reg(gpio, &aspeed_gpio_banks[i], reg_rdata);
> > +		const struct aspeed_gpio_bank *bank = &aspeed_gpio_banks[i];
> > +		void __iomem *addr = bank_reg(gpio, bank, reg_rdata);
> >  		gpio->dcache[i] = ioread32(addr);
> > +		aspeed_gpio_change_cmd_source(gpio, bank, 0, GPIO_CMDSRC_ARM);
> > +		aspeed_gpio_change_cmd_source(gpio, bank, 1, GPIO_CMDSRC_ARM);
> > +		aspeed_gpio_change_cmd_source(gpio, bank, 2, GPIO_CMDSRC_ARM);
> > +		aspeed_gpio_change_cmd_source(gpio, bank, 3, GPIO_CMDSRC_ARM);
> >  	}
> >  
> >  	rc = devm_gpiochip_add_data(&pdev->dev, &gpio->chip, gpio);
> > diff --git a/include/linux/gpio/aspeed.h b/include/linux/gpio/aspeed.h
> > new file mode 100644
> > index 000000000000..b6871c9b71f7
> > --- /dev/null
> > +++ b/include/linux/gpio/aspeed.h
> > @@ -0,0 +1,14 @@
> > +#ifndef __GPIO_ASPEED_H
> > +#define __GPIO_ASPEED_H
> > +
> > +struct aspeed_gpio_copro_ops {
> > +	int (*request_access)(void *data);
> > +	int (*release_access)(void *data);
> > +};
> > +
> > +int aspeed_gpio_copro_grab_gpio(struct gpio_desc *desc);
> > +int aspeed_gpio_copro_release_gpio(struct gpio_desc *desc);
> > +int aspeed_gpio_copro_set_ops(const struct aspeed_gpio_copro_ops *ops, 
> > void *data);
> > +
> > +
> > +#endif /* __GPIO_ASPEED_H */
> > -- 
> > 2.17.1
> > 
> 
> LGTM otherwise, so I'll send a r-b tag if we can live with that one nit-pick.
