From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 18 Apr 2024 09:11:47 +0930
Subject: [PATCH] peci: aspeed: Clear clock_divider value before setting
 it
In-Reply-To: <20240417134849.5793-1-iwona.winiarska@intel.com>
References: <20240417134849.5793-1-iwona.winiarska@intel.com>
Message-ID: <7b0ef5c90138e8c1d1829de249a480709170141b.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Iwona,

On Wed, 2024-04-17 at 15:48 +0200, Iwona Winiarska wrote:
> PECI clock divider is programmed on 10:8 bits of PECI Control register.
> Before setting a new value, clear bits read from hardware.
> 
> Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>

I think it would be best to add a Fixes: tag and Cc: stable in
accordance with the stable tree rules. Are you happy to do so?

Andrew

