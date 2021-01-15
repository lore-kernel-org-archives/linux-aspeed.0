From: Paul Fertser <fercerpav@gmail.com>
Date: Fri, 15 Jan 2021 14:18:29 +0300
Subject: [PATCH v29 1/6] drivers: jtag: Add JTAG core driver
In-Reply-To: <20200413222920.4722-2-ernesto.corona@intel.com>
References: <20200413222920.4722-1-ernesto.corona@intel.com>
 <20200413222920.4722-2-ernesto.corona@intel.com>
Message-ID: <20210115111829.GB2971@home.paul.comp>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Apr 13, 2020 at 03:29:15PM -0700, Ernesto Corona wrote:
> --- /dev/null
> +++ b/drivers/jtag/jtag.c
> +	 case JTAG_SIOCFREQ:
> +		if (!jtag->ops->freq_set)
> +			return -EOPNOTSUPP;
> +
> +		if (get_user(value, (__u32 __user *)arg))
> +			return -EFAULT;

Does this need to be a pointer to a variable even if it's just a
number?

> +	case JTAG_IOCXFER:
> +		if (copy_from_user(&xfer, (const void __user *)arg,
> +				   sizeof(struct jtag_xfer)))
> +			return -EFAULT;
> +
> +		if (xfer.length >= JTAG_MAX_XFER_DATA_LEN)
> +			return -EINVAL;
> +
> +		if (xfer.type > JTAG_SDR_XFER)
> +			return -EINVAL;
> +
> +		if (xfer.direction > JTAG_READ_WRITE_XFER)
> +			return -EINVAL;
> +
> +		if (xfer.endstate > JTAG_STATE_UPDATEIR)
> +			return -EINVAL;
> +
> +		data_size = DIV_ROUND_UP(xfer.length, BITS_PER_BYTE);
> +		xfer_data = memdup_user(u64_to_user_ptr(xfer.tdio), data_size);

So this might copy more bits than the user specified, but that's
probably OK.

> +		if (IS_ERR(xfer_data))
> +			return -EFAULT;
> +
> +		err = jtag->ops->xfer(jtag, &xfer, xfer_data);
> +		if (err) {
> +			kfree(xfer_data);
> +			return err;
> +		}
> +
> +		err = copy_to_user(u64_to_user_ptr(xfer.tdio),
> +				   (void *)xfer_data, data_size);

And this might overwrite some bits and it's not OK, at least not
without a warning in the documentation.

> --- /dev/null
> +++ b/include/uapi/linux/jtag.h
> @@ -0,0 +1,194 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +// include/uapi/linux/jtag.h - JTAG class driver uapi
> +//
> +// Copyright (c) 2018 Mellanox Technologies. All rights reserved.
> +// Copyright (c) 2018 Oleksandr Shamray <oleksandrs@mellanox.com>
> +
> +#ifndef __UAPI_LINUX_JTAG_H
> +#define __UAPI_LINUX_JTAG_H
> +

Missing <linux/types.h>

Other API comments will be sent as a reply to the "Documentation:
jtag: Add ABI documentation" patch as they are not
implementation-specific.

-- 
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav at gmail.com
