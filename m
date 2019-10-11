From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Fri, 11 Oct 2019 14:28:05 +0200
Subject: [PATCH 04/16] mtd: spi-nor: aspeed: Add read training
In-Reply-To: <20191004115919.20788-5-clg@kaod.org>
References: <20191004115919.20788-1-clg@kaod.org>
 <20191004115919.20788-5-clg@kaod.org>
Message-ID: <20191011142805.6cc3905c@dhcp-172-31-174-146.wireless.concordia.ca>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri,  4 Oct 2019 13:59:07 +0200
C?dric Le Goater <clg@kaod.org> wrote:

> +#define ASPEED_SMC_HCLK_DIV(i) \
> +	(aspeed_smc_hclk_divs[(i) - 1] << CONTROL_CLOCK_FREQ_SEL_SHIFT)
> +
> +static u32 aspeed_smc_default_read(struct aspeed_smc_chip *chip)
> +{
> +	/*
> +	 * Keep the 4Byte address mode on the AST2400 SPI controller.
> +	 * Other controllers set the 4Byte mode in the CE Control
> +	 * Register
> +	 */
> +	u32 ctl_mask = chip->controller->info == &spi_2400_info ?
> +		 CONTROL_IO_ADDRESS_4B : 0;
> +
> +	return (chip->ctl_val[smc_read] & ctl_mask) |
> +		(0x00 << 28) | /* Single bit */
> +		(0x00 << 24) | /* CE# max */
> +		(0x03 << 16) | /* use normal reads */
> +		(0x00 <<  8) | /* HCLK/16 */
> +		(0x00 <<  6) | /* no dummy cycle */
> +		(0x00);        /* normal mode */

IIUC, you're using a SPINOR_OP_READ operation to read the golden
buffer, and if I'm right, you start reading at offset 0 of the dirmap
window (offset 0 in the flash), so basically the first block in the NOR.
What happens if this block is erased? In that case your golden buf will
contain only 0xff values, and the read calibration is likely to be
useless (how can you determine if timings are good when IO pins always
stay high). Don't we have a command that return non-ff/non-0 data while
still being predictable and immutable? Do you expect users to always
flash a pattern that helps calibrating those delays?

> +}
> +
> +static int aspeed_smc_optimize_read(struct aspeed_smc_chip *chip,
> +				    u32 max_freq)
> +{
> +	u8 *golden_buf, *test_buf;
> +	int i, rc, best_div = -1;
> +	u32 save_read_val = chip->ctl_val[smc_read];
> +	u32 ahb_freq = chip->controller->clk_frequency;
> +
> +	dev_dbg(chip->nor.dev, "AHB frequency: %d MHz", ahb_freq / 1000000);
> +
> +	test_buf = kmalloc(CALIBRATE_BUF_SIZE * 2, GFP_KERNEL);
> +	golden_buf = test_buf + CALIBRATE_BUF_SIZE;
> +
> +	/* We start with the dumbest setting (keep 4Byte bit) and read
> +	 * some data
> +	 */
> +	chip->ctl_val[smc_read] = aspeed_smc_default_read(chip);
> +
> +	writel(chip->ctl_val[smc_read], chip->ctl);
> +
> +	memcpy_fromio(golden_buf, chip->ahb_base, CALIBRATE_BUF_SIZE);
> +
> +	/* Establish our read mode with freq field set to 0 (HCLK/16) */
> +	chip->ctl_val[smc_read] = save_read_val & 0xfffff0ff;
> +
> +	/* Check if calibration data is suitable */
> +	if (!aspeed_smc_check_calib_data(golden_buf, CALIBRATE_BUF_SIZE)) {
> +		dev_info(chip->nor.dev,
> +			 "Calibration area too uniform, using low speed");
> +		writel(chip->ctl_val[smc_read], chip->ctl);
> +		kfree(test_buf);
> +		return 0;
> +	}
> +
> +	/* Now we iterate the HCLK dividers until we find our breaking point */
> +	for (i = ARRAY_SIZE(aspeed_smc_hclk_divs); i > 0; i--) {
> +		u32 tv, freq;
> +
> +		/* Compare timing to max */
> +		freq = ahb_freq / i;
> +		if (freq > max_freq)
> +			continue;
> +
> +		/* Set the timing */
> +		tv = chip->ctl_val[smc_read] | ASPEED_SMC_HCLK_DIV(i);
> +		writel(tv, chip->ctl);
> +		dev_dbg(chip->nor.dev, "Trying HCLK/%d...", i);
> +		rc = aspeed_smc_calibrate_reads(chip, i, golden_buf, test_buf);
> +		if (rc == 0)
> +			best_div = i;
> +	}
> +	kfree(test_buf);
> +
> +	/* Nothing found ? */
> +	if (best_div < 0) {
> +		dev_warn(chip->nor.dev, "No good frequency, using dumb slow");
> +	} else {
> +		dev_dbg(chip->nor.dev, "Found good read timings at HCLK/%d",
> +			best_div);
> +		chip->ctl_val[smc_read] |= ASPEED_SMC_HCLK_DIV(best_div);
> +	}
> +
> +	writel(chip->ctl_val[smc_read], chip->ctl);
> +	return 0;
> +}


