From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 23 Feb 2021 14:34:55 -0800
Subject: [PATCH v3 2/4] ARM: dts: aspeed: modify I2C node to support
 buffer mode
In-Reply-To: <20210216182735.11639-3-jae.hyun.yoo@linux.intel.com>
References: <20210216182735.11639-1-jae.hyun.yoo@linux.intel.com>
 <20210216182735.11639-3-jae.hyun.yoo@linux.intel.com>
Message-ID: <CAFd5g46K4=xPLFnvnAKY0MibU9s87Hd_OpYupYQwZ+Yq=W2-mQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Feb 16, 2021 at 10:15 AM Jae Hyun Yoo
<jae.hyun.yoo@linux.intel.com> wrote:
>
> This driver uses byte mode that makes lots of interrupt calls
> so it's not good for performance. Also, it makes the driver very
> timing sensitive. To improve performance of the driver, this commit
> modifies I2C node to support buffer mode which uses I2C SRAM buffer
> instead of using a single byte buffer.
>
> AST2400:
> It has 2 KBytes (256 Bytes x 8 pages) of I2C SRAM buffer pool from
> 0x1e78a800 to 0x1e78afff that can be used for all busses with
> buffer pool manipulation. To simplify implementation for supporting
> both AST2400 and AST2500, it assigns each 128 Bytes per bus without
> using buffer pool manipulation so total 1792 Bytes of I2C SRAM
> buffer will be used.
>
> AST2500:
> It has 16 Bytes of individual I2C SRAM buffer per each bus and its
> range is from 0x1e78a200 to 0x1e78a2df, so it doesn't have 'buffer
> page selection' bit field in the Function control register, and
> neither 'base address pointer' bit field in the Pool buffer control
> register it has. To simplify implementation for supporting both
> AST2400 and AST2500, it writes zeros on those register bit fields
> but it's okay because it does nothing in AST2500.
>
> AST2600:
> It has 32 Bytes of individual I2C SRAM buffer per each bus and its
> range is from 0x1e78ac00 to 0x1e78adff. Works just like AST2500
> does.
>
> See Documentation/devicetree/bindings/i2c/i2c-aspeed.txt for
> enabling buffer mode details.
>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Reviewed-by: C?dric Le Goater <clg@kaod.org>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
