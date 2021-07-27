From: David Müller (ELSOFT AG) <d.mueller@elsoft.ch>
Date: Tue, 27 Jul 2021 13:16:47 +0200
Subject: [PATCH 10/14] peci: Add peci-cpu driver
In-Reply-To: <20210712220447.957418-11-iwona.winiarska@intel.com>
References: <20210712220447.957418-1-iwona.winiarska@intel.com>
 <20210712220447.957418-11-iwona.winiarska@intel.com>
Message-ID: <26dbd0d3-c326-96a5-2ec7-4fc3387865e9@elsoft.ch>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Iwona Winiarska wrote:

> +static const struct peci_device_id peci_cpu_device_ids[] = {
> +	{ /* Haswell Xeon */
> +		.family	= 6,
> +		.model	= INTEL_FAM6_HASWELL_X,
> +		.data	= "hsx",
> +	},
> +	{ /* Broadwell Xeon */
> +		.family	= 6,
> +		.model	= INTEL_FAM6_BROADWELL_X,
> +		.data	= "bdx",
> +	},
> +	{ /* Broadwell Xeon D */
> +		.family	= 6,
> +		.model	= INTEL_FAM6_BROADWELL_D,
> +		.data	= "skxd",

I think this should read "bdxd" as "skxd" does not exist in the
cputemp/dimmtemp drivers.
