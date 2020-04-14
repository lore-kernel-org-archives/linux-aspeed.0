From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Tue, 14 Apr 2020 12:15:48 +0300
Subject: [PATCH v29 6/6] drivers: jtag: Add JTAG core driver Maintainers
In-Reply-To: <20200413222920.4722-7-ernesto.corona@intel.com>
References: <20200413222920.4722-1-ernesto.corona@intel.com>
 <20200413222920.4722-7-ernesto.corona@intel.com>
Message-ID: <20200414091548.GH34613@smile.fi.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Apr 13, 2020 at 03:29:20PM -0700, Ernesto Corona wrote:
> JTAG class driver provide infrastructure to support hardware/software
> JTAG platform drivers. It provide user layer API interface for flashing
> and debugging external devices which equipped with JTAG interface
> using standard transactions.

Don't forget to run
      scripts/parse-maintainers.pl --input=MAINTAINERS --output=MAINTAINERS --order

> Signed-off-by: Oleksandr Shamray <oleksandrs@mellanox.com>
> Signed-off-by: Ernesto Corona <ernesto.corona@intel.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Jiri Pirko <jiri@mellanox.com>
> Cc: Vadim Pasternak <vadimp@mellanox.com>
> Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Cc: Steven Filary <steven.a.filary@intel.com>
> Cc: Amithash Prasad <amithash@fb.com>
> Cc: Patrick Williams <patrickw3@fb.com>
> Cc: Rgrs <rgrs@protonmail.com>
> ---
>  MAINTAINERS | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e64e5db31497..96d20fbb719c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9144,6 +9144,17 @@ L:	linux-serial at vger.kernel.org
>  S:	Orphan
>  F:	drivers/tty/serial/jsm/
>  
> +JTAG SUBSYSTEM
> +M:	Oleksandr Shamray <oleksandrs@mellanox.com>
> +M:	Vadim Pasternak <vadimp@mellanox.com>
> +M	Ernesto Corona <ernesto.corona@intel.com>
> +S:	Maintained
> +F:	include/linux/jtag.h
> +F:	include/uapi/linux/jtag.h
> +F:	drivers/jtag/
> +F:	Documentation/devicetree/bindings/jtag/
> +F:	Documentation/ABI/testing/jtag-dev
> +
>  K10TEMP HARDWARE MONITORING DRIVER
>  M:	Clemens Ladisch <clemens@ladisch.de>
>  L:	linux-hwmon at vger.kernel.org
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


