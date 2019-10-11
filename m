From: Cédric Le Goater <clg@kaod.org>
Date: Fri, 11 Oct 2019 16:03:45 +0200
Subject: [PATCH 04/16] mtd: spi-nor: aspeed: Add read training
In-Reply-To: <a933999d-cb3d-ef3c-8a0d-a1f022817543@ti.com>
References: <20191004115919.20788-1-clg@kaod.org>
 <20191004115919.20788-5-clg@kaod.org>
 <20191011142805.6cc3905c@dhcp-172-31-174-146.wireless.concordia.ca>
 <a933999d-cb3d-ef3c-8a0d-a1f022817543@ti.com>
Message-ID: <b52ea3a3-11c3-212b-7e02-44c76427bb46@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 11/10/2019 15:13, Vignesh Raghavendra wrote:
> Hi Cedric,
> 
> On 11/10/19 5:58 PM, Boris Brezillon wrote:
>> On Fri,  4 Oct 2019 13:59:07 +0200
>> C?dric Le Goater <clg@kaod.org> wrote:
>>
>>> +#define ASPEED_SMC_HCLK_DIV(i) \
>>> +	(aspeed_smc_hclk_divs[(i) - 1] << CONTROL_CLOCK_FREQ_SEL_SHIFT)
>>> +
>>> +static u32 aspeed_smc_default_read(struct aspeed_smc_chip *chip)
>>> +{
>>> +	/*
>>> +	 * Keep the 4Byte address mode on the AST2400 SPI controller.
>>> +	 * Other controllers set the 4Byte mode in the CE Control
>>> +	 * Register
>>> +	 */
>>> +	u32 ctl_mask = chip->controller->info == &spi_2400_info ?
>>> +		 CONTROL_IO_ADDRESS_4B : 0;
>>> +
>>> +	return (chip->ctl_val[smc_read] & ctl_mask) |
>>> +		(0x00 << 28) | /* Single bit */
>>> +		(0x00 << 24) | /* CE# max */
>>> +		(0x03 << 16) | /* use normal reads */
>>> +		(0x00 <<  8) | /* HCLK/16 */
>>> +		(0x00 <<  6) | /* no dummy cycle */
>>> +		(0x00);        /* normal mode */
>>
>> IIUC, you're using a SPINOR_OP_READ operation to read the golden
>> buffer, and if I'm right, you start reading at offset 0 of the dirmap
>> window (offset 0 in the flash), so basically the first block in the NOR.
>> What happens if this block is erased? In that case your golden buf will
>> contain only 0xff values, and the read calibration is likely to be
>> useless (how can you determine if timings are good when IO pins always
>> stay high). Don't we have a command that return non-ff/non-0 data while
>> still being predictable and immutable? Do you expect users to always
>> flash a pattern that helps calibrating those delays?
>>
> 
> Yes, this is precisely my concern as well. I have been developing
> training sequence for cadence-quadspi controller (requirements are
> similar to what you have here) and found that its better to use read
> only data such as SFDP table data to calibrate. Cadence-quadspi requires
> training only in higher performance modes like Quad/Octal DTR mode and
> needs 16 bytes of known data for calibration. Hence SFDP works well for
> my case.

OK. Good to know.

> But the problem here is that, aspeed controller needs 16K of known data.

It's a choice we made on the first P8 systems we had.

> SFDP table is not that big and read beyond address space is not required
> to wrap around.
> Wondering if you really need to read 16K amount of data for calibration?

May be not. I agree this is taking a bit of time as we read 10 times
and compares: 3s on boot time on an ast2400 I think. Joel could tell
better. We could reduce the amount of data read and the number of 
loops surely.  

As for the validity of the data, we check with the golden buffer with
aspeed_smc_check_calib_data().

If it's too uniform, like on a flash never written too, we will need
a first write and a reboot to have faster read speed.

Thanks,

C. 

> 
> Regards
> Vignesh
> 
>>> +}
>>> +
>>> +static int aspeed_smc_optimize_read(struct aspeed_smc_chip *chip,
>>> +				    u32 max_freq)
>>> +{
>>> +	u8 *golden_buf, *test_buf;
>>> +	int i, rc, best_div = -1;
>>> +	u32 save_read_val = chip->ctl_val[smc_read];
>>> +	u32 ahb_freq = chip->controller->clk_frequency;
>>> +
>>> +	dev_dbg(chip->nor.dev, "AHB frequency: %d MHz", ahb_freq / 1000000);
>>> +
>>> +	test_buf = kmalloc(CALIBRATE_BUF_SIZE * 2, GFP_KERNEL);
>>> +	golden_buf = test_buf + CALIBRATE_BUF_SIZE;
>>> +
>>> +	/* We start with the dumbest setting (keep 4Byte bit) and read
>>> +	 * some data
>>> +	 */
>>> +	chip->ctl_val[smc_read] = aspeed_smc_default_read(chip);
>>> +
>>> +	writel(chip->ctl_val[smc_read], chip->ctl);
>>> +
>>> +	memcpy_fromio(golden_buf, chip->ahb_base, CALIBRATE_BUF_SIZE);
>>> +
>>> +	/* Establish our read mode with freq field set to 0 (HCLK/16) */
>>> +	chip->ctl_val[smc_read] = save_read_val & 0xfffff0ff;
>>> +
>>> +	/* Check if calibration data is suitable */
>>> +	if (!aspeed_smc_check_calib_data(golden_buf, CALIBRATE_BUF_SIZE)) {
>>> +		dev_info(chip->nor.dev,
>>> +			 "Calibration area too uniform, using low speed");
>>> +		writel(chip->ctl_val[smc_read], chip->ctl);
>>> +		kfree(test_buf);
>>> +		return 0;
>>> +	}
>>> +
>>> +	/* Now we iterate the HCLK dividers until we find our breaking point */
>>> +	for (i = ARRAY_SIZE(aspeed_smc_hclk_divs); i > 0; i--) {
>>> +		u32 tv, freq;
>>> +
>>> +		/* Compare timing to max */
>>> +		freq = ahb_freq / i;
>>> +		if (freq > max_freq)
>>> +			continue;
>>> +
>>> +		/* Set the timing */
>>> +		tv = chip->ctl_val[smc_read] | ASPEED_SMC_HCLK_DIV(i);
>>> +		writel(tv, chip->ctl);
>>> +		dev_dbg(chip->nor.dev, "Trying HCLK/%d...", i);
>>> +		rc = aspeed_smc_calibrate_reads(chip, i, golden_buf, test_buf);
>>> +		if (rc == 0)
>>> +			best_div = i;
>>> +	}
>>> +	kfree(test_buf);
>>> +
>>> +	/* Nothing found ? */
>>> +	if (best_div < 0) {
>>> +		dev_warn(chip->nor.dev, "No good frequency, using dumb slow");
>>> +	} else {
>>> +		dev_dbg(chip->nor.dev, "Found good read timings at HCLK/%d",
>>> +			best_div);
>>> +		chip->ctl_val[smc_read] |= ASPEED_SMC_HCLK_DIV(best_div);
>>> +	}
>>> +
>>> +	writel(chip->ctl_val[smc_read], chip->ctl);
>>> +	return 0;
>>> +}
>>
>>
> 

