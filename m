From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Thu, 31 Aug 2023 17:18:26 +0300
Subject: [PATCH v12 2/2] i2c: aspeed: support ast2600 i2c new register
 mode driver
In-Reply-To: <SEZPR06MB5269A43F801EF04F39461174F2E5A@SEZPR06MB5269.apcprd06.prod.outlook.com>
References: <20230714074522.23827-1-ryan_chen@aspeedtech.com>
 <20230714074522.23827-3-ryan_chen@aspeedtech.com>
 <ZLENe5B3gi/oNTQp@smile.fi.intel.com>
 <SEZPR06MB5269A43F801EF04F39461174F2E5A@SEZPR06MB5269.apcprd06.prod.outlook.com>
Message-ID: <ZPChMrsKrOQppY1F@smile.fi.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Aug 31, 2023 at 06:04:30AM +0000, Ryan Chen wrote:
> > On Fri, Jul 14, 2023 at 03:45:22PM +0800, Ryan Chen wrote:

Stop overquoting! Remove the context you are not answering to.

...

> > > +				if (--i % 4 != 3)
> > > +					writel(*(u32 *)wbuf, i2c_bus->buf_base + i - (i % 4));
> > > +				writel(AST2600_I2CC_SET_TX_BUF_LEN(xfer_len),
> > > +				       i2c_bus->reg_base + AST2600_I2CC_BUFF_CTRL);
> > 
> > Wrong memory accessors. You should use something from asm/byteorder.h
> > which includes linux/byteorder/generic.h.
> > 
> 
> Are you preferring add comment to explain more by following?
> 				/*
> 				 * The controller's buffer register supports dword writes only.
> 				 * Therefore, write dwords to the buffer register in a 4-byte aligned,
> 				 * and write the remaining unaligned data at the end.
> 				 */

This does not explain endianess bug (or feature) it has.
You are using CPU side byteorder for the aligned data.
This is not okay, on top of the code looking ugly and
prone to errors. Note, that somebody may refer to your
code, once accepted, in educational purposes, but since
the code is not good written, it makes a false positive
impression that this is the right thing to do in the similar
case elsewhere.

Please, fix this.

> 				for (i = 0; i < xfer_len; i++) {
> 					wbuf[i % 4] = msg->buf[i2c_bus->master_xfer_cnt + i];
> 					/* accumulating 4 bytes of data, write as a Dword to the buffer register */
> 					if (i % 4 == 3)
> 						writel(*(u32 *)wbuf, i2c_bus->buf_base + i - 3);
> 				}
> 				/* less than 4 bytes of remaining data, write the remaining part as a Dword */
> 				if (--i % 4 != 3)
> 					writel(*(u32 *)wbuf, i2c_bus->buf_base + i - (i % 4));
> 				writel(AST2600_I2CC_SET_TX_BUF_LEN(xfer_len),
> 				       i2c_bus->reg_base + AST2600_I2CC_BUFF_CTRL);
> 
> Or more columns (use get_unaligned_le32(wbuf); ) by following.
> 
> 	for (i = 0; i < xfer_len; i++) {
> 		wbuf[i % 4] = msg->buf[i2c_bus->master_xfer_cnt + i];
> 		if (i % 4 == 3) {
> 			wbuf_dword = get_unaligned_le32(wbuf);
> 			writel(wbuf_dword, i2c_bus->buf_base + i - 3);
> 		}
> 	}
> 
> 	if (--i % 4 != 3) {
> 		wbuf_dword = get_unaligned_le32(wbuf);
> 		writel(wbuf_dword, i2c_bus->buf_base + i - (i % 4));
> 	}

-- 
With Best Regards,
Andy Shevchenko


