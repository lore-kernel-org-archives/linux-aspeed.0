From: 'andriy.shevchenko@linux.intel.com' <andriy.shevchenko@linux.intel.com>
Date: Thu, 1 Feb 2024 13:32:10 +0200
Subject: [PATCH 30 7/7] Add AST2500 and AST2600 JTAG device in DTS
In-Reply-To: <LV8PR11MB8463F88C2364A08DEF3ABAC28B7D2@LV8PR11MB8463.namprd11.prod.outlook.com>
References: <LV8PR11MB8463F88C2364A08DEF3ABAC28B7D2@LV8PR11MB8463.namprd11.prod.outlook.com>
Message-ID: <ZbuBOmtyYdlmnCBa@smile.fi.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jan 30, 2024 at 11:32:48PM +0000, Corona, Ernesto wrote:
> Adding aspeed jtag device to device tree
> 
> Signed-off-by: Ernesto Corona <ernesto.corona@intel.com>
> Signed-off-by: Omar Castro <omar.eduardo.castro@linux.intel.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

First of all, please use --thread to git-format-patch when preparing the
series.

> Cc: Jiri Pirko <jiri@nvidia.com>
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
> Cc: Luke Chen <luke_chen@aspeedtech.com>
> Cc: Billy Tsai <billy_tsai@aspeedtech.com>

Second, please avoid flooding commit message with unneeded details, i.e. move
these Cc:s to...

> ---
...the after this cutter line.

-- 
With Best Regards,
Andy Shevchenko


