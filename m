From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 23 Nov 2021 07:56:08 -0800
Subject: [PATCH v4 11/13] hwmon: peci: Add dimmtemp driver
Message-ID: <20211123155608.GA2258206@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Nov 23, 2021 at 03:07:04PM +0100, Iwona Winiarska wrote:
> Add peci-dimmtemp driver for Temperature Sensor on DIMM readings that
> are accessible via the processor PECI interface.
> 
> The main use case for the driver (and PECI interface) is out-of-band
> management, where we're able to obtain thermal readings from an external
> entity connected with PECI, e.g. BMC on server platforms.
> 
> Co-developed-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---

[ ... ]

> +static int check_populated_dimms(struct peci_dimmtemp *priv)
> +{
> +	int chan_rank_max = priv->gen_info->chan_rank_max;
> +	int dimm_idx_max = priv->gen_info->dimm_idx_max;
> +	u32 chan_rank_empty = 0;
> +	u64 dimm_mask = 0;
> +	int chan_rank, dimm_idx, ret;
> +	u32 pcs;
> +
> +	BUILD_BUG_ON(BITS_PER_TYPE(chan_rank_empty) < CHAN_RANK_MAX);
> +	BUILD_BUG_ON(BITS_PER_TYPE(dimm_mask) < DIMM_NUMS_MAX);
> +	if (chan_rank_max * dimm_idx_max > DIMM_NUMS_MAX) {
> +		WARN_ONCE(1, "Unsupported number of DIMMs - chan_rank_max: %d, dimm_idx_max: %d",
> +			  chan_rank_max, dimm_idx_max);
> +		return -EINVAL;
> +	}
> +
> +	for (chan_rank = 0; chan_rank < chan_rank_max; chan_rank++) {
> +		ret = peci_pcs_read(priv->peci_dev, PECI_PCS_DDR_DIMM_TEMP, chan_rank, &pcs);
> +		if (ret) {
> +			/*
> +			 * Overall, we expect either success or -EINVAL in
> +			 * order to determine whether DIMM is populated or not.
> +			 * For anything else we fall back to deferring the
> +			 * detection to be performed at a later point in time.
> +			 */
> +			if (ret == -EINVAL) {
> +				chan_rank_empty |= BIT(chan_rank);
> +				continue;
> +			}
> +
> +			return -EAGAIN;
> +		}
> +
> +		for (dimm_idx = 0; dimm_idx < dimm_idx_max; dimm_idx++)
> +			if (__dimm_temp(pcs, dimm_idx))
> +				dimm_mask |= BIT(chan_rank * dimm_idx_max + dimm_idx);
> +	}
> +
> +	/*
> +	 * If we got all -EINVALs, it means that the CPU doesn't have any
> +	 * DIMMs. Unfortunately, it may also happen at the very start of
> +	 * host platform boot. Retrying a couple of times lets us make sure
> +	 * that the state is persistent.
> +	 */
> +	if (chan_rank_empty == GENMASK(chan_rank_max - 1, 0)) {
> +		if (priv->no_dimm_retry_count < NO_DIMM_RETRY_COUNT_MAX) {
> +			priv->no_dimm_retry_count++;
> +
> +			return -EAGAIN;
> +		} else {
> +			return -ENODEV;
> +		}

Static analyzers will complain "else after return is unnecessary".

Guenter
