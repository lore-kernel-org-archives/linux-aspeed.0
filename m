From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Wed, 09 Oct 2024 12:27:01 +1030
Subject: [PATCH v7 5/7] gpio: aspeed: Create llops to handle hardware
 access
In-Reply-To: <20241008081450.1490955-6-billy_tsai@aspeedtech.com>
References: <20241008081450.1490955-1-billy_tsai@aspeedtech.com>
	 <20241008081450.1490955-6-billy_tsai@aspeedtech.com>
Message-ID: <38c72aa9f4cbd3d4a6dc9f8baac20e9bd87db644.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2024-10-08 at 16:14 +0800, Billy Tsai wrote:
> Add low-level operations (llops) to abstract the register access for GPIO
> registers and the coprocessor request/release. With this abstraction
> layer, the driver can separate the hardware and software logic, making it
> easier to extend the driver to support different hardware register
> layouts.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

I've applied the series to here and booted it on a AST2600. I did some
brief testing with a logic analyzer and gpio{get,set} and didn't see
anything surprising, so:

Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au> # AST2600

Thanks Billy!

Andrew
