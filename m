From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Mon, 26 Feb 2024 14:43:13 +1030
Subject: [PATCH v1 04/14] serial: 8250_aspeed_vuart: Switch to use
 uart_read_port_properties()
In-Reply-To: <20240221183442.4124354-5-andriy.shevchenko@linux.intel.com>
References: <20240221183442.4124354-1-andriy.shevchenko@linux.intel.com>
	 <20240221183442.4124354-5-andriy.shevchenko@linux.intel.com>
Message-ID: <00b5f735bd9c151812445d40348d70f4b4bd474d.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2024-02-21 at 20:31 +0200, Andy Shevchenko wrote:
> Since we have now a common helper to read port properties
> use it instead of sparse home grown solution.
> 
> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
